//
//  NYCSchoolScore.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 24/11/23.
//

import Foundation

typealias NYCSchoolScoreResponse = [NYCSchoolScore]

public struct NYCSchoolScore {
    let dbn: String
    let numOfSatTestTakers: String?
    
    let satCriticalReadingAvgScore: String?
    let satMathAvgScore: String?
    let satWritingAvgScore: String?
}

extension NYCSchoolScore: Decodable {
    enum CodingKeys: CodingKey {
        case dbn, numOfSatTestTakers, satCriticalReadingAvgScore, satMathAvgScore, satWritingAvgScore
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        numOfSatTestTakers = String(try values.decode(String.self, forKey: .numOfSatTestTakers))
        
        satCriticalReadingAvgScore = try values.decode(String.self, forKey: .satCriticalReadingAvgScore)
        satMathAvgScore = try values.decode(String.self, forKey: .satMathAvgScore)
        satWritingAvgScore = try values.decode(String.self, forKey: .satWritingAvgScore)
    }
}
