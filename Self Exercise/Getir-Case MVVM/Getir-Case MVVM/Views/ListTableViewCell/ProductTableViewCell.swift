//
//  ProductTableViewCell.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 18.09.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    fileprivate let reusableIdentifier = "ProductTableViewCell"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(product: ProductViewModel) {
        self.productName.text = product.productName
        self.productPrice.text = "\(product.productPrice)"
      // self.productDescription.text = product.productDescription
        
        self.contentView.layoutIfNeeded()
    }
    
}
