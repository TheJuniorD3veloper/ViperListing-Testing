//
//  ListingPresneterTestCase.swift
//  ViperListingTests
//
//  Created by Aman Verma on 22/06/24.
//

import XCTest



class MockListingInteractor: ListingInteractorInputProtocol {
    var fetchItemsCalled = false
    var fetchItemsURLString: String?

    func fetchItems(urlString: String) {
        fetchItemsCalled = true
        fetchItemsURLString = urlString
    }
}

class MockView: ListingViewProtocol {
    var showItemsCalled = false
    var showErrorCalled = false
    var items: [Item]?
    var errorMessage: String?
    
    var showItemsClosure: (([Item]) -> Void)?
    var showErrorClosure: ((String) -> Void)?

    func showItems(_ items: [Item]) {
        showItemsCalled = true
        self.items = items
        showItemsClosure?(items)
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        errorMessage = message
        showErrorClosure?(message)
    }
}


class MockListingRouter: ListingRouterProtocol {
    
}

import XCTest
@testable import ViperListing

class ListingPresenterTests: XCTestCase {
    var presenter: ListingPresenter!
    var mockInteractor: MockListingInteractor!
    var mockRouter: MockListingRouter!
    var mockView: MockView!

    override func setUp() {
        super.setUp()
        mockInteractor = MockListingInteractor()
        mockRouter = MockListingRouter()
        mockView = MockView()
        presenter = ListingPresenter(interactor: mockInteractor, router: mockRouter, view: mockView)
    }

    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        mockView = nil
        super.tearDown()
    }

    func testLoadItems() {
        // Given

        // When
        presenter.loadItems()

        // Then
        XCTAssertTrue(mockInteractor.fetchItemsCalled)
    }

    func testDidFetchItems() {
        // Given
        let items = [Item(id: 2,name: "Item1"), Item(id: 1, name: "Item2")] // Assume Item has a name property
        let expectation = self.expectation(description: "showItems called")

        mockView.showItemsClosure = { items in
            expectation.fulfill()
        }

        // When
        presenter.didFetchItems(items)

        // Then
        waitForExpectations(timeout: 1) { error in
            XCTAssertTrue(self.mockView.showItemsCalled)
            XCTAssertEqual(self.mockView.items, items)
        }
    }

    func testDidFailToFetchItems() {
        // Given
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error message"])
        let expectation = self.expectation(description: "showError called")

        mockView.showErrorClosure = { message in
            expectation.fulfill()
        }

        // When
        presenter.didFailToFetchItems(with: error)

        // Then
        waitForExpectations(timeout: 1) { error in
            XCTAssertTrue(self.mockView.showErrorCalled)
            XCTAssertEqual(self.mockView.errorMessage, "Error message")
        }
    }
}
