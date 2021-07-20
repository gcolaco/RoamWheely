//
//  RoamWheelyTests.swift
//  RoamWheelyTests
//
//  Created by Gustavo Colaço on 19/07/21.
//

import XCTest
@testable import RoamWheely

class RoamWheelyTests: XCTestCase {
    var sut: OptionsVC!

    override func setUpWithError() throws {
        sut = OptionsVC()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    
    func testModelIsBeingProperlyAdded() {
        sut.options.append(Option(optionName: "option1"))
        sut.options.append(Option(optionName: "option2"))
        sut.options.append(Option(optionName: "option3"))
        
        XCTAssertEqual("option1", sut.options[0].optionName)
        XCTAssertEqual("option2", sut.options[1].optionName)
        XCTAssertEqual("option3", sut.options[2].optionName)
        
    }
    

    func testIfInitalVCLoads() {
        XCTAssertNotNil(sut.view)
    }
    
    func testTableViewLoads() {
        XCTAssertNotNil(sut.tableView, "TableView not initiated")
    }
    
    
    func testTableViewNumberOfRowsInSection() {
        
        sut.options.append(Option(optionName: "option1"))
        sut.options.append(Option(optionName: "option2"))
        
        let expectedRows = sut.options.count;
        let tableView = UITableView()

        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: expectedRows)
        XCTAssertEqual(numberOfRows, 2,
                       "Number of rows in table should match number of options")
        
    }
    
}

