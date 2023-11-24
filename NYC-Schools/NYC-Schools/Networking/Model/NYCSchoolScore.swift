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
    let numOfSatTestTakers: Int?
    
    let satCriticalReadingAvgScore: Int?
    let satMathAvgScore: Int?
    let satWritingAvgScore: Int?
}

extension NYCSchoolScore: Decodable {
    enum CodingKeys: CodingKey {
        case dbn, numOfSatTestTakers, satCriticalReadingAvgScore, satMathAvgScore, satWritingAvgScore
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        numOfSatTestTakers = Int(try values.decode(String.self, forKey: .numOfSatTestTakers))
        
        satCriticalReadingAvgScore = Int(try values.decode(String.self, forKey: .satCriticalReadingAvgScore))
        satMathAvgScore = Int(try values.decode(String.self, forKey: .satMathAvgScore))
        satWritingAvgScore = Int(try values.decode(String.self, forKey: .satWritingAvgScore))
    }
}
