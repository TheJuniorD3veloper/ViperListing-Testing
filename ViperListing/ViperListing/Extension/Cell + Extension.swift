//
//  Cell + Extension.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

import Foundation


import UIKit

protocol CellIdentifiable {

    static var nib: UINib { get }

    static var identifier: String { get }

}

extension CellIdentifiable {

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

}
