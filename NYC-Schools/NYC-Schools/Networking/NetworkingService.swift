//
//  NetworkingService.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

public protocol NetworkingServiceProtocol {
    func makeRequest<T: Decodable>(session: URLSession, _ absoluteURL: String) async throws -> T
}

public final class NetworkingService: NSObject {
    
    var desc: String = ""
    static let shared = NetworkingService()

}

extension NetworkingService : NetworkingServiceProtocol {
    public func makeRequest<T: Decodable>(session: URLSession = .shared, _ absoluteURL: String) async throws -> T {
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                    delegate: self,
                                    delegateQueue: nil)
        guard let url = URL(string: absoluteURL) else { throw NetworkingError.invalidURL }
        
        let request = URLRequest(url: url)
        
        let response: (Data, URLResponse)
        do {
            response = try await urlSession.data(for: request)
        } catch {
            throw NetworkingError.customError(error: error)
        }
        
        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NetworkingError.failedToDecode
        }
    }
}
extension NetworkingService: URLSessionDelegate {
    public func urlSession(_: URLSession, task _: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
        }
        return completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}

extension URLRequest {
#if DEBUG
    static func allowsAnyHTTPSCertificate(forHost host: String) -> Bool {
        return true
    }
#endif
}
