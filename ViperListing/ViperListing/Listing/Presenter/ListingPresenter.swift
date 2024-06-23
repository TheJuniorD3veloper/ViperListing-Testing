//
//  ListingPresenter.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

import Foundation

import Combine

protocol ListingPresenterProtocol: AnyObject {
    func loadItems()
}

class ListingPresenter: ListingPresenterProtocol, ListingInteractorOutputProtocol {
    private let interactor: ListingInteractorInputProtocol
    private let router: ListingRouterProtocol
    private weak var view: ListingViewProtocol?
    private var cancellables = Set<AnyCancellable>()

    init(interactor: ListingInteractorInputProtocol, router: ListingRouterProtocol, view: ListingViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    func loadItems() {
        interactor.fetchItems(urlString: Constants.listingUrl.rawValue)
    }

    
    func didFetchItems(_ items: [Item]) {
           dump(items)
           DispatchQueue.main.async {
               self.view?.showItems(items)
           }
       }

       func didFailToFetchItems(with error: Error) {
           DispatchQueue.main.async {
               self.view?.showError(error.localizedDescription)
           }
       }
}
