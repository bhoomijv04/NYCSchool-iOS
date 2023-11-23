//
//  SchoolDataModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 20/11/23.
//

import Foundation

public final class HomeViewCellViewModel: ObservableObject {
    
    public var school: NYCSchool
    
    public init(data: NYCSchool) {
        self.school = data
    }
    static let sampleData = [
        HomeViewCellViewModel(data: NYCSchool(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    ")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "21K728", name: "Liberation Diploma Plus High School", overview: "", phoneNumber: "", email: "", website: "", totalStudents: 206, graduationRate: nil, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BROOKLYN")),
        HomeViewCellViewModel(data: NYCSchool(dbn: "08X282", name: "Women's Academy of Excellence", overview: "The Women’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!", phoneNumber: "718-542-0740", email: "sburns@schools.nyc.gov", website: "schools.nyc.gov/SchoolPortals/08/X282", totalStudents: 338, graduationRate: 0.612999976, attendanceRate: nil, latitude: nil, longitude: nil, borough: "BRONX    "))
    ]
}

public struct NYCSchool: Identifiable {
    public var id: UUID
    public let dbn: String
    public let name: String
    public let overview: String?
    //contact
    public let phoneNumber: String?
    public let email: String?
    public let website: String?
    public let totalStudents: Int?
    // rate
    public let graduationRate: Double?
    public let attendanceRate: Double?
    // location
    public let latitude: Double?
    public let longitude: Double?
    public let borough: String?
    
    
    public init(id: UUID = UUID(), dbn: String, name: String, overview: String?, phoneNumber: String?, email: String?, website: String?, totalStudents: Int?, graduationRate: Double?, attendanceRate: Double?, latitude: Double?, longitude: Double?, borough: String?) {
        self.id = id
        self.dbn = dbn
        self.name = name
        self.overview = overview
        self.phoneNumber = phoneNumber
        self.email = email
        self.website = website
        self.totalStudents = totalStudents
        self.graduationRate = graduationRate
        self.attendanceRate = attendanceRate
        self.latitude = latitude
        self.longitude = longitude
        self.borough = borough
    }
}


