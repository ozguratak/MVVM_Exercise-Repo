//
//  ViewController.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController, ProductListViewModelDelegate {
    
    func dataDidLoad() {
       self.productList.reloadData()
        self.loading.stopAnimating()
        print("delegate çalıştı")
    }
    
    private let propductListVM = ProductListViewModel()
    
    private let productList: UITableView = {
        let list = UITableView()
        list.register(UINib(nibName: String(describing: ProductTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductTableViewCell.self)) 
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .brown
        return list
    }()
    
    private let loading: UIActivityIndicatorView = {
        let loadingIcon = UIActivityIndicatorView()
        loadingIcon.color = UIColor.darkGray
        loadingIcon.translatesAutoresizingMaskIntoConstraints = false
        loadingIcon.style = .large
        loadingIcon.hidesWhenStopped = true
        return loadingIcon
    }()
    
    private let cartButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        propductListVM.getProductListFromUrl()
        productList.delegate = self
        productList.dataSource = self
        view.addSubview(productList)
        view.addSubview(loading)
        view.addSubview(cartButton)
        propductListVM.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        
        productList.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    productList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    productList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    productList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    productList.bottomAnchor.constraint(equalTo: cartButton.topAnchor, constant: -16)
                ])
        
        NSLayoutConstraint.activate([
                    cartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                    cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                    cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
                ])
        
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        cartButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cartButton.setImage(UIImage(systemName: "Cart"), for: .normal)
        
            }
    
    @objc func buttonAction() {
        print("sepet tetiklendi")
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CartViewController.self)) as? CartViewController {
                   self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propductListVM.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTableViewCell.self), for: indexPath) as! ProductTableViewCell
        cell.configureCell(product: propductListVM.productsViewModel(at: indexPath.row))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProductDetailViewController.self)) as? ProductDetailViewController {
            self.navigationController?.pushViewController(detailVC, animated: true)
           detailVC.vm = propductListVM.productsViewModel(at: indexPath.row)
          
        }
        
    }
    
    
    

}
