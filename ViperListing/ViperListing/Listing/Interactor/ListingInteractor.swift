//
//  ListingPageInteractor.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

//import Foundation
//import Combine
//
//protocol ListingInteractorOutputProtocol: AnyObject {
//    func didFetchItems(_ items: [Item])
//    func didFailToFetchItems(with error: Error)
//}
//
//
//protocol ListingInteractorInputProtocol: AnyObject {
//    func fetchItems()
//}
//
//class ListingInteractor: ListingInteractorInputProtocol {
//    var output: ListingInteractorOutputProtocol?
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetchItems() {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: [Item].self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    self.output?.didFailToFetchItems(with: error)
//                }
//            }, receiveValue: { items in
//                self.output?.didFetchItems(items)
//            })
//            .store(in: &cancellables)
//    }
//}


import Combine
import Foundation

protocol ListingInteractorInputProtocol: AnyObject {
    func fetchItems(urlString: String)
}
protocol ListingInteractorOutputProtocol: AnyObject {
    func didFetchItems(_ items: [Item])
    func didFailToFetchItems(with error: Error)
}
class ListingInteractor: ListingInteractorInputProtocol {
    var output: ListingInteractorOutputProtocol?
    private var cancellables = Set<AnyCancellable>()

    func fetchItems(urlString: String) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: [Item].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.output?.didFailToFetchItems(with: error)
                case .finished:
                    break
                }
            }, receiveValue: { items in
                self.output?.didFetchItems(items)
            })
            .store(in: &cancellables)
    }
}

