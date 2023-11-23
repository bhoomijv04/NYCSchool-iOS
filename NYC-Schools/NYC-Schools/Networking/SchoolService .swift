//
//  NetworkingService.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

public protocol SchoolServiceProtocol {
    func fetchSchoolList() async throws -> [NYCSchool]
    func fetchSchoolListFromJSON() -> [NYCSchool]
}

public final class SchoolService: NSObject {
    let service = NetworkingService.shared
}

typealias SchoolDirectoryResponse = [NYCSchool]

extension SchoolService : SchoolServiceProtocol {
    
    public func fetchSchoolList() async throws -> [NYCSchool] {
        let path = "https://data.cityofnewyork.us/Education/DOE-High-School-Dirctory-2017/s3k6-pzi2"
        let result: [NYCSchool] = try await service.makeRequest(session: .shared, path)
        return result
    }
    
    public func fetchSchoolListFromJSON() -> [NYCSchool] {
        if let url = Bundle.main.url(forResource: "schoolsList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SchoolDirectoryResponse.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
