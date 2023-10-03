//
//  ProductListViewModel.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import Foundation
import UIKit

protocol ProductListViewModelDelegate: AnyObject {
    func dataDidLoad()
}

class ProductListViewModel {
    private let service = WebService.shared
    private let url = URL(string: "https://mocki.io/v1/6bb59bbc-e757-4e71-9267-2fee84658ff2")
    var products: [ProductViewModel]
    weak var delegate: ProductListViewModelDelegate?
    
    
    func getProductListFromUrl() {
        service.load(url: url) { result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    if let productList = list {
                        self.products = productList.map(ProductViewModel.init)
                        self.delegate?.dataDidLoad()
                        print(self.products)
                        print(self.products.count)
                     
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init() {
        self.products = [ProductViewModel]()
    }
    
    func productsViewModel(at index: Int) -> ProductViewModel {
        return self.products[index]
    }
    
}

struct ProductViewModel {
    var product: ProductModel
    
    var productName: String {
        if let name = self.product.productName {
            return name
        }
        return "Unknown Product"
    }
    
    var productImage: String {
        if let image = self.product.productImage {
            return image
        }
        return self.product.productImage!
    }
    
    var productPrice: Double {
        if let price = self.product.productPrice {
            return price
        }
        return 0.0
    }
    
    var productDescription: String {
        if let descrition = self.product.productDescription {
            return descrition
        }
        return "Unknown Description"
    }
}

