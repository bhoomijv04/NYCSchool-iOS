//
//  NetworkingService.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

// MARK: Service class for School API
public protocol SchoolServiceProtocol {
    func fetchSchoolList() async throws -> [NYCSchool]
    func fetchSchoolListFromJSON() -> [NYCSchool]
    func fetchSATScoreFromJSON() -> [NYCSchoolScore]
}

public final class SchoolService: NSObject {
    static let shared = SchoolService()
    let service = NetworkingService.shared
}

// MARK: Load Data from API
extension SchoolService : SchoolServiceProtocol {

    public func fetchSchoolList() async throws -> [NYCSchool] {
        let path = "https://data.cityofnewyork.us/resource/s3k6-pzi2"
        let result: [NYCSchool] = try await service.makeRequest(path)
        return result
    }
    
    public func fetchSchoolScore(idx: String) async throws -> [NYCSchoolScore] {
        let path = "https://data.cityofnewyork.us/Education/DOE-High-School-Dirctory-2017/s3k6-pzi2"
        let result: [NYCSchoolScore] = try await service.makeRequest(path)
        return result
    }
}

// MARK: Load Data from JSON
extension SchoolService {
    public func fetchSchoolListFromJSON() -> [NYCSchool] {
        if let url = Bundle.main.url(forResource: "schoolsList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NYCSchoolDirectoryResponse.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
    
    public func fetchSATScoreFromJSON() -> [NYCSchoolScore] {
        if let url = Bundle.main.url(forResource: "scoresData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NYCSchoolScoreResponse.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
