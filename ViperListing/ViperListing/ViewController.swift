//
//  ViewController.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

import UIKit

class ListingModuleBuilder {
    static func build() -> UIViewController {
        let interactor = ListingInteractor()
        let router = ListingRouter()
        let view = ListingViewController()
        let presenter = ListingPresenter(interactor: interactor, router: router, view: view)

        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vc: ListingViewController = ListingModuleBuilder.build() as! ListingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

