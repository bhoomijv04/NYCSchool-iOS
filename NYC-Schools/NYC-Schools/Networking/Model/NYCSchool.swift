//
//  NYCSchool.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 24/11/23.
//

import Foundation

// MARK: Data Model

typealias NYCSchoolDirectoryResponse = [NYCSchool]

public struct NYCSchool: Decodable {
    
    public let dbn: String
    public let school_name: String
    public let overview_paragraph: String?
    //contact
    public let phone_number: String?
    public let school_email: String?
    public let website: String?
    public let total_students: String?
    // rate
    public let graduation_rate: Double?
    public let attendance_rate: Double?
    // location
    public let latitude: Double?
    public let longitude: Double?
    public let borough: String?
    public var location: String?
    public var extracurricular_activities: String?
    
    
    public init(dbn: String, name: String, overview: String?, phoneNumber: String?, email: String?, website: String?, totalStudents: String?, graduationRate: Double?, attendanceRate: Double?, latitude: Double?, longitude: Double?, borough: String?, location: String?, extracurricular_activities: String?) {
        self.dbn = dbn
        self.school_name = name
        self.overview_paragraph = overview
        self.phone_number = phoneNumber
        self.school_email = email
        self.website = website
        self.total_students = totalStudents
        self.graduation_rate = graduationRate
        self.attendance_rate = attendanceRate
        self.latitude = latitude
        self.longitude = longitude
        self.borough = borough
        self.location = location
        self.extracurricular_activities = extracurricular_activities
    }
    
    enum CodingKeys: String, CodingKey {
        case dbn, phone_number, website, total_students, graduation_rate, attendance_rate, latitude, longitude, borough, school_name, overview_paragraph, school_email, location, extracurricular_activities
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        
        school_name = (try values.decode(String.self, forKey: .school_name)).replacingOccurrences(of: "Â", with: "")
        
        overview_paragraph = (try? values.decode(String.self, forKey: .overview_paragraph))?.replacingOccurrences(of: "Â", with: "")
        
        phone_number = try? values.decode(String.self, forKey: .phone_number)
        school_email = try? values.decode(String.self, forKey: .school_email)
        
        let rawWebsite = try? values.decode(String.self, forKey: .website)
        if let rawWebsite {
            website = !rawWebsite.hasPrefix("http") ? "http://" + rawWebsite : rawWebsite
        } else {
            website = nil
        }
        
        total_students = try values.decode(String.self, forKey: .total_students)
        graduation_rate = Double((try? values.decode(String.self, forKey: .graduation_rate)) ?? "")
        attendance_rate = Double((try? values.decode(String.self, forKey: .attendance_rate)) ?? "")
        latitude = Double((try? values.decode(String.self, forKey: .latitude)) ?? "")
        longitude = Double((try? values.decode(String.self, forKey: .longitude)) ?? "")
        borough = try? values.decode(String.self, forKey: .borough)
        location = try? values.decode(String.self, forKey: .location)
        if let value = location?.components(separatedBy: "(").first {
            location = value
        }
        extracurricular_activities =  try? values.decode(String.self, forKey: .extracurricular_activities)
        
    }
}
