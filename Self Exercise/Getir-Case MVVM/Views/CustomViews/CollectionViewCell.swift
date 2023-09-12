//
//  CollectionViewCell.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 12.09.2023.
//

import UIKit
import Combine

class CollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var productImage: UIImageView!
//    @IBOutlet weak var productName: UILabel!
//    @IBOutlet weak var productPrice: UILabel!
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    static let reuseIdentifier = "CollectionViewCell"
    
    
    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()

    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Stack View Oluştur
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4.0

        // Stack View'a öğeleri ekle
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(productNameLabel)
        stackView.addArrangedSubview(productPriceLabel)

        // Stack View'ı hücreye ekle
        addSubview(stackView)

        // Constraints Ayarla
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 80),
            productImage.heightAnchor.constraint(equalToConstant: 80),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with product: ProductViewModel) {  
        loadImage(for: product).sink {[unowned self] image in self.showImage(image: image) }
        productNameLabel.text = product.productName
        productPriceLabel.text = "\(product.productPrice)"
    }
    
    private func showImage(image: UIImage?) {
        productImage.alpha = 0.0
        animator?.stopAnimation(false)
        productImage.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.productImage.alpha = 1.0
        })
    }
    
    private func loadImage(for product: ProductViewModel) -> AnyPublisher<UIImage?, Never> {
        return Just(product.productImage)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                if let url = URL(string: product.productImage) {
                    return ImageLoader.shared.loadImage(from: url)
                } else {
                    print("URL error in cache mechanisms load funciton!")
                }
                return ImageLoader.shared.loadImage(from: URL(string: "https://github.com/logo")!)
            })
            .eraseToAnyPublisher()
    }
    
}
