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
        print("delegate çalıştı")
    }
    
    private let propductListVM = ProductListViewModel()
    
    private let productList: UICollectionView = {
        let listViewFlowLayout = UICollectionViewFlowLayout()
        let listView = UICollectionView(frame: .zero, collectionViewLayout: listViewFlowLayout)
        listView.translatesAutoresizingMaskIntoConstraints = false
        listViewFlowLayout.sectionInset = UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
        listViewFlowLayout.itemSize = CGSize(width: 80, height: 80)
        listViewFlowLayout.scrollDirection = .vertical
        listView.backgroundColor = .brown
        listView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
        listView.layer.cornerRadius = 12
        return listView
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
        propductListVM.delegate = self
        productList.delegate = self
        productList.dataSource = self
        propductListVM.getProductListFromUrl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(productList)
        view.addSubview(cartButton)
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



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propductListVM.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = propductListVM.productsViewModel(at: indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as! CollectionViewCell
        cell.configure(with: vm)
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProductDetailViewController.self)) as? ProductDetailViewController {
            detailVC.vm = propductListVM.productsViewModel(at: indexPath.row)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
