//
//  NetworkingService.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

// MARK: Network task Protocol
public protocol NetworkingServiceProtocol {
    func makeRequest<T: Decodable>(_ absoluteURL: String) async throws -> T
}

public final class NYCNetworkingService: NSObject {
    static let shared = NYCNetworkingService()
    private var networkMonitor = NYCNetworkMonitor()
    struct Authorization {
        static let appToken = "mtMETbliAcn6mWopyAo3mj2Cq"
    }
}

extension NYCNetworkingService : NetworkingServiceProtocol {
    public func makeRequest<T: Decodable>(_ absoluteURL: String) async throws -> T {
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        
       let session = URLSession(configuration: configuration)
        
        if networkMonitor.isConnected == false {
            throw NYCNetworkingError.noInternet
        }
        
        guard let url = URL(string: absoluteURL) else { throw NYCNetworkingError.invalidURL }
        
        var request = URLRequest(url: url)
        request.setValue("X-App-Token", forHTTPHeaderField: Authorization.appToken)
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        
        let response: (Data, URLResponse)
        do {
            response = try await session.data(for: request)
        } catch {
            throw NYCNetworkingError.customError(error: error)
        }
        
        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NYCNetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NYCNetworkingError.failedToDecode
        }
    }
}

extension NYCNetworkingService: URLSessionDelegate {
    public func urlSession(_: URLSession, task _: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
        }
        return completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}

// MARK: AVOID SSL Certifficate Error
extension URLRequest {
#if DEBUG
    static func allowsAnyHTTPSCertificate(forHost host: String) -> Bool {
        return true
    }
#endif
}
