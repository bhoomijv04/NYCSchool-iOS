//
//  SchoolListCellViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 20/11/23.
//

import Foundation
import UIKit
import MapKit
import MessageUI

public final class SchoolListCellViewModel {
    
    public var school: NYCSchool
    public var score: NYCSchoolScore?
    public var id: UUID
    public var openURL: ((String)?) -> Void
    public var callPhone: ((String)?) -> Void
    public var openMap: ((NYCSchool)) -> Void
    public var openEmail: ((String)?) -> Void
    
    public init(data: NYCSchool, score: NYCSchoolScore?, id: UUID = UUID(), openURL:@escaping ((String)?) -> Void, callPhone:@escaping ((String)?) -> Void, openMap: @escaping ((NYCSchool)) -> Void, openEmail: @escaping ((String)?) -> Void) {
        self.school = data
        self.id = id
        self.score = score
        self.openURL = openURL
        self.callPhone = callPhone
        self.openMap = openMap
        self.openEmail = openEmail
    }

    public func openURL(urlString: String?) {
        openURL(urlString)
    }
    
    public func callPhone(phone: String?) {
        callPhone(phone)
    }
    
    public func openMap(school: NYCSchool) {
        openMap(school)
    }
    
    func sendEmail(addresss: String?) {
      openEmail(addresss)
    }
}

