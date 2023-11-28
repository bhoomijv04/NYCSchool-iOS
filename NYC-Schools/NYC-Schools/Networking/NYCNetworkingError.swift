//
//  NetworkError.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

// MARK: Network Error
enum NYCNetworkingError: Error {
    case invalidURL
    case customError(error: Error)
    case invalidStatusCode(statusCode: Int)
    case failedToDecode
    case noInternet
}

extension NYCNetworkingError: Equatable {
    static func == (lhs: NYCNetworkingError, rhs: NYCNetworkingError) -> Bool {
        switch (lhs, rhs) {
            case (.invalidURL, .invalidURL):
                return true
            case let (.customError(lhsError), .customError(rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            case let (.invalidStatusCode(lhsCode), .invalidStatusCode(rhsCode)):
                return lhsCode == rhsCode
            case (.failedToDecode, .failedToDecode):
                return true
            default:
                return false
        }
    }
}
