//
//  OrderViewModel.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 16.08.2023.
//

import Foundation
import UIKit

class OrderListViewModel { //Adından da anlaşılacağı gibi bu ViewModel aşağıdaki tek bir order için yartılan view modelin liste hlaine geldiği bir view model. Bu yüzden ilk olarak Tek bir order'a ait olan OrderViewModel yapımızı yeni ORderListViewModel yapımızın içine initilaze ediyoruz bunu yaparkende bir listeye ihtiyaç duyduğumuz için bunu bir array içerisinde tanımlayarak yapıyoruz.
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
}

extension OrderListViewModel { // Detay sayfası gibi bir yapı için dizayn edilmiş tek bir order'ı index'ine bağlı olarak getirecek olan fonksiyona ait extension teorik olarak bir Mutating fonksiyon yaratıyoruz. OrderViewModel struct'ı içerisinde yer alan Order objesini ilgili indexten getirebiliyoruz. Buna benzer bir değişim oluşturucu fonksiyonu eklediğimizde Order objesinin yapısını da değiştirebiliriz.
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

//MARK: Particular Order View Model FOR ONLY ONE ORDER!

struct OrderViewModel { //ViewModel Model ile iletişimde SADECE TEK BİR ORDER İÇİN ORANGİZE EDİLMİŞ OLAN YAPI!
    let order: Order
}

extension OrderViewModel { //ViewModel yapımızın model ile olan iletişimi sonrası aldığı verileri kendi içindeki değişkenlere eşitlediği alan. SADECE TEK BİR ORDER İÇİN ORANGİZE EDİLMİŞ OLAN YAPI!
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
}
