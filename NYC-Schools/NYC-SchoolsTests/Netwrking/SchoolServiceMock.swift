//
//  NetowrkingServiceMock.swift
//  NYC-SchoolsTests
//
//  Created by Bhoomi Vadgama on 28/11/23.
//

import Foundation
@testable import NYC_Schools

class SchoolServiceMock: SchoolServiceProtocol {
    
    var decoder = JSONDecoder()
    
    func fetchSchoolListFromJSON() -> [NYCSchool] {
        []
    }
    
    func fetchSATScoreFromJSON() -> [NYCSchoolScore] {
        []
    }
    
    func fetchSchoolList() async throws -> [NYCSchool] {
        guard let path = Bundle.main.path(forResource: "schoolsList", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            fatalError("Failed to get the static schools file")
        }
        let staticSchools = try! decoder.decode(NYCSchoolDirectoryResponse.self, from: data)
        return staticSchools
    }
    
    func fetchSchoolScore() async throws -> [NYCSchoolScore] {
        guard let path = Bundle.main.path(forResource: "scoresData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            fatalError("Failed to get the static schools file")
        }
        let staticSchools = try! decoder.decode(NYCSchoolScoreResponse.self, from: data)
        return staticSchools
    }
}
