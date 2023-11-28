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

struct URLFactory {
    static let schoolList = "https://data.cityofnewyork.us/resource/s3k6-pzi2"
    static let schoolScore = "https://data.cityofnewyork.us/resource/f9bf-2cp4"
}

struct JSONFactory {
    static let schoolList = "schoolsList"
    static let schoolScore = "scoresData"
}

public final class NYCSchoolService: ObservableObject {
    static let shared = NYCSchoolService()
    
    let service = NYCNetworkingService.shared
}

// MARK: Load Data from API
extension NYCSchoolService : SchoolServiceProtocol {

    public func fetchSchoolList() async throws -> [NYCSchool] {
        let result: NYCSchoolDirectoryResponse = try await service.makeRequest(URLFactory.schoolList)
        return result
    }
    
    public func fetchSchoolScore() async throws -> [NYCSchoolScore] {
        let result: NYCSchoolScoreResponse = try await service.makeRequest(URLFactory.schoolScore)
        return result
    }
}

// MARK: Load Data from JSON
extension NYCSchoolService {
    public func fetchSchoolListFromJSON() -> [NYCSchool] {
        if let url = Bundle.main.url(forResource: JSONFactory.schoolList, withExtension: "json") {
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
        if let url = Bundle.main.url(forResource: JSONFactory.schoolScore, withExtension: "json") {
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
