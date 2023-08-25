//
//  Order.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 16.08.2023.
//

import Foundation
//MARK: Data Model for Orders

// Modeli tanımlarken zaten 4 değişkenimiz var. Bu 4 değişkenden 2 tanesi requirements gereğince müşteriden müşteriye değişiklik gösterebilir durumda. Geri kalan 2 tanesi ise standart olarak eklenmiş mağaza referanslı ürünler. Bu nedenle onları birer enum içerisinde gerektiği durumda update edilebilmesi için liste halinde ekledik.

struct Order: Codable {
    var name: String
    var email: String
    var type: CoffeType
    var size: CoffeSize
}

enum CoffeType: String, Codable, CaseIterable {
    case cappucino
    case latte
    case espresso
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

//MARK: POST Actions

/*
 Bu extension, bir initilazer içerir. İnitilazer'ın amacı, Codable olarak tasarlanan modelimizin webAPI'ye post edilebilmesi için gereken modelin yapılanmasını sağlamaktır. Genel tablosuna bakıldığında NewOrderViewModel'i kendisine referans alarak hareket eder. NewOrderViewModel'i, AddOrderViewController isimli View tarafından yapılandırılır. Ardından initilaze edilmiş olan yapımız temel data modelimiz olan Order modeline dönüştürülür ve daha sonra JSON Encoder kullanılarak JSON formata çevrilerek post edilir.
 */
extension Order {
    
    init?(_ vm: NewOrderViewModel) {
        guard let name = vm.name,
              let email = vm.email,
              let type = CoffeType(rawValue: vm.selectedType!.lowercased()), //lowercased ibaresini, view'da capitalized yaparak kullandığımız için ekliyoruz. çünkü referans olan order modelimiz içerisinde bunlar küçük harfle yazılıyor.
              let size = CoffeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.size = size
        self.type = type
    }
}
