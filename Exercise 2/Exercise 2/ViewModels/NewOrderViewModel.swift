//
//  NewOrderViewModel.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 17.08.2023.
//

import Foundation


struct NewOrderViewModel {
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeType.allCases.map {$0.rawValue.capitalized} //İlkkez kullandığım bir değişken tipi. Order içerisinde tanımlı olan CoffeType enum'ına CaseIterable protokolünü ekledik. Bu protokol sayesinde enum içerisinde yer alan tüm case'lerin bir veya bir çoğunu bir array halinde ekleyebilecek bir mutatable değişken yaratmış olduk. Oldukça kullanışlı bir değişken tipi edindik!
    }
    
    var sizes: [String] {
        return CoffeSize.allCases.map {$0.rawValue.capitalized}
    }
}

