import XCTest
import Combine
@testable import ViperListing

class ListingInteractorTests: XCTestCase {
    var interactor: ListingInteractor!
    var mockOutput: MockListingInteractorOutput!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockOutput = MockListingInteractorOutput()
        interactor = ListingInteractor()
        interactor.output = mockOutput
    }

    override func tearDown() {
        interactor = nil
        mockOutput = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchItemsSuccess() {
        let expectation = self.expectation(description: "didFetchItems should be called")
        mockOutput.didFetchItemsExpectation = expectation

        interactor.fetchItems(urlString: Constants.listingUrl.rawValue)

        waitForExpectations(timeout: 5) { error in
            XCTAssertTrue(self.mockOutput.didFetchItemsCalled)
            XCTAssertNotNil(self.mockOutput.items)
        }
    }

    func testFetchItemsFailure() {
        let expectation = self.expectation(description: "didFailToFetchItems should be called")
        mockOutput.didFailToFetchItemsExpectation = expectation

        // Use a wrong URL to induce failure
        let badURL = "https://jsonplaceholder.typicode.com/invalidendpoint"
        self.interactor.fetchItems(urlString: badURL)

        waitForExpectations(timeout: 5) { error in
            XCTAssertTrue(self.mockOutput.didFailToFetchItemsCalled)
            XCTAssertNotNil(self.mockOutput.error)
        }
    }
}





class MockListingInteractorOutput: ListingInteractorOutputProtocol {
    var didFetchItemsCalled = false
    var didFailToFetchItemsCalled = false
    var items: [Item]?
    var error: Error?

    var didFetchItemsExpectation: XCTestExpectation?
    var didFailToFetchItemsExpectation: XCTestExpectation?

    func didFetchItems(_ items: [Item]) {
        didFetchItemsCalled = true
        self.items = items
        didFetchItemsExpectation?.fulfill()
    }

    func didFailToFetchItems(with error: Error) {
        didFailToFetchItemsCalled = true
        self.error = error
        didFailToFetchItemsExpectation?.fulfill()
    }
}
