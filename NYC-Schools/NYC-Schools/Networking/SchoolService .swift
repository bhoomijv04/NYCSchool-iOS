//
//  NetworkingService.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 23/11/23.
//

import Foundation

/*
 
 NYC Open Data
 
 Directory: 2017 DOE High School Directory
 https://data.cityofnewyork.us/Education/2017-DOE-High-School-Directory/s3k6-pzi2
 
 Directory: 2012 SAT Results
 https://data.cityofnewyork.us/Education/2012-SAT-Results/f9bf-2cp4
 
 */

// MARK: Service class for School API
public protocol SchoolServiceProtocol {
    func fetchSchoolList() async throws -> [NYCSchool]
    func fetchSchoolScore() async throws -> [NYCSchoolScore]
    func fetchSchoolListFromJSON() -> [NYCSchool]
    func fetchSATScoreFromJSON() -> [NYCSchoolScore]
}

public final class SchoolService: NSObject {
    static let shared = SchoolService()
    let service = NetworkingService.shared
}

struct SchoolServiceURL {
    static let schoolList = "https://data.cityofnewyork.us/resource/s3k6-pzi2"
    static let schoolScore = "https://data.cityofnewyork.us/resource/f9bf-2cp4"
}

// MARK: Load Data from API
extension SchoolService : SchoolServiceProtocol {

    public func fetchSchoolList() async throws -> [NYCSchool] {
        let result: NYCSchoolDirectoryResponse = try await service.makeRequest(SchoolServiceURL.schoolList)
        return result
    }
    
    public func fetchSchoolScore() async throws -> [NYCSchoolScore] {
        let result: NYCSchoolScoreResponse = try await service.makeRequest(SchoolServiceURL.schoolScore)
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
