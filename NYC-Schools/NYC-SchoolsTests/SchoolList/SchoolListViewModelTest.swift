//
//  HomeViewModelTest.swift
//  NYC-SchoolsTests
//
//  Created by Bhoomi Vadgama on 28/11/23.
//

import Foundation
@testable import NYC_Schools
import XCTest


final class SchoolListViewModelTest: XCTestCase {
    
    var viewModel: SchoolListViewModel?
    private let coordinator = SchoolListViewCoordinatorMock()
    
    override func setUp() {
        super.setUp()
        viewModel = SchoolListViewModel(coordinator: coordinator, schoolService: SchoolServiceMock())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSuccessfulLoadSchoolList() async {
        XCTAssertTrue(viewModel?.schools.count == 0)
        await viewModel?.getNYCSchoolList()
        XCTAssertTrue(viewModel?.schools.count ?? 0 > 0)
    }
}
