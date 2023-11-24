//
//  SchoolDataModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 20/11/23.
//

import Foundation


public final class SchoolDetaislScoreModel: ObservableObject {
    
    public var school: NYCSchoolScore
    
    public init(data: NYCSchoolScore) {
        self.school = data
    }
}

