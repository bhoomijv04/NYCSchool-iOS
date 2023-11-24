//
//  SchoolDataModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 20/11/23.
//

import Foundation


public final class HomeViewCellViewModel: ObservableObject {
    
    public var school: NYCSchool
    public var id: UUID
    
    public init(data: NYCSchool, id: UUID = UUID()) {
        self.school = data
        self.id = id
    }
}

