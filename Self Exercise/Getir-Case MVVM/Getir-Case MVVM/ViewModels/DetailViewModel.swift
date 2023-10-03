//
//  DetailViewModel.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import Foundation
import UIKit
import Combine

class DetailViewModel {
    var product: ProductViewModel?
    
    init(product: ProductViewModel? = nil) {
        self.product = product
    }
    
    var productName: String {
        if let name = product?.productName {
            return name
        }
        return product!.productName
    }
    
    var productPrice: String {
        if let price = product?.productPrice  {
            return String(describing: price)
        }
        
        return String(describing: product?.productPrice)
    }
    
    var productDetails: String {
        if let details = product?.productDescription {
            return details
        }
        return product!.productDescription
    }
    
    var productImageLink: String {
        if let imageLink = product?.productImage {
            return imageLink
        }
        
        return product!.productImage
    }
    
}
