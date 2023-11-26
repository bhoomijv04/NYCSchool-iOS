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
    let num_of_sat_test_takers: String?
    
    let sat_critical_reading_avg_score: String?
    let sat_math_avg_score: String?
    let sat_writing_avg_score: String?
}

extension NYCSchoolScore: Decodable {
    enum CodingKeys: CodingKey {
        case dbn, num_of_sat_test_takers, sat_critical_reading_avg_score, sat_math_avg_score, sat_writing_avg_score
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        num_of_sat_test_takers = String(try values.decode(String.self, forKey: .num_of_sat_test_takers))
        
        sat_critical_reading_avg_score = try values.decode(String.self, forKey: .sat_critical_reading_avg_score)
        sat_math_avg_score = try values.decode(String.self, forKey: .sat_math_avg_score)
        sat_writing_avg_score = try values.decode(String.self, forKey: .sat_writing_avg_score)
    }
}
