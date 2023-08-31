//
//  Binding.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

//MARK: Binding Sınıfı

/*
 Binding kelime anlamıyla bağlamak olarak çevirirsek burada yaptığımız iş veriyi biribirne bağlamak. Nasıl çalıştığı konusuna gelecek olursak; farklı tiplerde(Type) nesne(Object) alabilecek Binding adında bir sınıf tanımlıyarak başlıyoruz. Ardından sınıfımızın içerisine, T tipinde bir parametreyi void olarak dönen bir Listener adında typeallias tnaımlıyoruz. yani aslında T tip parametreyi Void olarak dönme işlemine Listener olarak bir tanımlama yaptık.
 
 artından Listener typeallias'ını bir değişken olarak sınıfımızın içine tanımladık. Şimdi bize bu veri bağlama işini yapacak olan fonksiyon lazım. Yapacağımız şey çok basit, aldığımız T tipindeki parametreyi kendisine atayarak binding nesnesi içindeki listener nesnesine bağlayacağız.
 
 Bir noktada bu veriyi güncellememiz gerekebilir. bunun içinde bir update fonksiyonu yazıyoruz. update fonskiyonumuz ise listener değişkeni içerisinde T tipindeki value değerini güncellemek. bunun içinde listener'ımıza bir value değeri initilaze ediyoruz. 
 */

import Foundation

class Binding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func update(_ value: T) {
        listener?(value)
    }
}
