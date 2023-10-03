//
//  ProductModel.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import Foundation

struct ProductModel: Codable {
    var productName: String?
    var productDescription: String?
    var productPrice: Double?
    var productImage: String?
}

typealias ProductListModel = [ProductModel]?
