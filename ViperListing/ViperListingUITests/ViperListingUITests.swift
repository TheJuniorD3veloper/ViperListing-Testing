//
//  ViperListingUITests.swift
//  ViperListingUITests
//
//  Created by TheJunirD3v on 10/06/24.
//

import XCTest


final class ListingViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testListingViewDisplaysItems() {
        // Launch the app
        app.launch()

        // Wait for the table view to appear
        let tableView = app.tables.element
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))

        // Check if the table view has cells
        XCTAssertTrue(tableView.cells.count > 0, "The table view should have at least one cell.")

        // Verify the content of the first cell
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell should exist.")
        XCTAssertTrue(firstCell.staticTexts["Leanne Graham"].exists, "The first cell should display 'Item1'.")
        firstCell.tap()
        tableView.swipeUp()

        
    }
    
    
}

