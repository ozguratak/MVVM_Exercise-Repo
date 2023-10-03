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
    
    private let loading: UIActivityIndicatorView = {
       let loadingIcon = UIActivityIndicatorView()
        
        return loadingIcon
    }()
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "Star")
        return image
    }()
    
    private let productName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 17)
        name.textColor = .black
        name.textAlignment = .center
        name.numberOfLines = 0
        return name
    }()
    
    private let productDescription: UILabel = {
        let description = UILabel()
        description.font = UIFont.italicSystemFont(ofSize: 14)
        description.textColor = .darkGray
        description.textAlignment = .center
        description.numberOfLines = 0
        return description
    }()
    
    private let productPrice: UILabel = {
        let price = UILabel()
        price.font = UIFont.boldSystemFont(ofSize: 21)
        price.textColor = .gray
        price.textAlignment = .center
        price.numberOfLines = 1
        return price
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let productStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .equalCentering
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productStack)
//        view.addSubview(addButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    @objc func itemAddedToCart() {
        
    }
    
    func setupUI() {
        self.productName.text = self.vm?.productName
           self.productDescription.text = self.vm?.productDescription
           self.productPrice.text = "\(self.vm!.productPrice)" 
    
           self.productStack.addArrangedSubview(productImage)
           self.productStack.addArrangedSubview(productName)
           self.productStack.addArrangedSubview(productDescription)
           self.productStack.addArrangedSubview(productPrice)
           
           productStack.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               productStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               productStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               productStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               productStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])
    }
}
