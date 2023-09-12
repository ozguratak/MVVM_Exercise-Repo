//
//  ProductDetailsViewController.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    var vm: ProductViewModel?
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let productName: UILabel = {
        let name = UILabel()
        
        return name
    }()
    
    private let productDescription: UILabel = {
        let description = UILabel()
        
        
        return description
    }()
    
    private let productPrice: UILabel = {
        let price = UILabel()
        
        return price
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
}
