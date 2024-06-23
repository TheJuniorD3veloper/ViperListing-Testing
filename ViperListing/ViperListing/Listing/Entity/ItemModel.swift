//
//  ItemModel.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

import Foundation

struct Item: Codable,Equatable {
    let id: Int
    let name: String
}


enum Constants :String {
    case listingUrl = "https://jsonplaceholder.typicode.com/users"
}
