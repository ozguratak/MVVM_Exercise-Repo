//
//  BindingTextField.swift
//  BindingMVVM
//
//  Created by Özgür  Atak  on 25.08.2023.
//

//MARK: Binding of TextField
/*

  BindingTextField kontrolcüsünün olayı, UItextField'dan inherit edilmiş bir kontrolvü oluşturmak bunun için ilk başta bir initilazer ve coder oluşturuyoruz. bir frame initilazer'ı ve storyboard'da veya interface içinde kullanabilmek için bir de coder ekliyoruz. ama storyvoardda kullanmayacağız.
 
 Bu yağılandırmada esas amacımız MVVM design patterninin alt yapısını sağlayacak olan View ve ViewModel arasındaki haberleşme ve sahip olma olayını düzenlemek. Bir View'ın mutlaka bir ViewModel'i olmak zorundadır ancak bir ViewModel'in birden çok View'ı olabilir. Bu yaklaşımla bakıldığında binding, verilerin transfer edilmesi ve View'ların ön planda iş akışını sağlamaktan başka hiç bir görevinin olmamasını sağlamaktır. Binding sayesinde bir veriyi bir ViewModel üzerinde güncelleyip başka Viewlarda da kolayca görüntülenebilir hale getirebiliriz. Bu sayede View'lar için yazdığımız kodlar azalır, proje içerisinde bulunan bileşenler daha modüler hale gelir ve güncellenmeleri, varsa hatalarının giderilmesi daha kolay hale gelir. 

 */

import Foundation
import UIKit

//MARK: Nasıl Çalışır?
/*
 ilk olarak View içerisinde BindingTextField üzerinden türetilecek bir TextField nesnesi eklenir, constarintleri ve diğer placeholderların vs verilebilmesi için BindingTextField'a zaten farme ve coder ekledik.
 
 TextField nesnesinin tanımlamalarını yaptıktan sonra TextField'ın metinini ViewModel'e bağlamak için textFieldName.bind olarak callback closuere'ı çağrılır. closure içerisinde hangi viewModel'e textField'ın text'i bağlanacaksa tanımlaması yapılır.
 
 Arka planda ise; textField üzerinden alınan string parametresi boş bir nesneye atanacak biçimde textChanged değişkeni olarak tanımlanır ve void olarak initilaze edilir.
 
 textField üzerinde her değişiklik yapıldığında bind fonksiyonu tetiklendiği için döngü kendini tekrar eder ve her seferinde initilaze edilen değeri günceller. closure olarak viewModeli günceller
 
 Bu döngü sayesinde View'da bulunan textField'da yapılan her değişiklik doğrudan ViewModel'e işlenir.
 */

class BindingTextField: UITextField {
    
    var textChanged: (String) -> Void = { _ in } //burada stringi alıp empty body'e initilaze ediyoruz
    
    override init(frame: CGRect) { //UI içerisine ekleyebilmek için bir frame initilaze ediyoruz.
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) { //UI içerisine ekleyebilmek için bir coder initilaze ediyoruz.
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() { // esas kullanacağımız initilazer aslında bu. Bu initlazerın olayı bir tetik görevi görmek ve yarattığımız nesneyi dinlemek. editingChanged olduğunda textFieldDidChange adındaki fonksiyonumuzu devreye alacak.Bu fonksiyon text'i safe unwrap edecek ardından bir empty body'e initilaze edecek.
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> Void) { // kullanıcı birlşeyler yazdığında veya sildiğinde veya yeniden yazdığında süreci başlatacak olan kısmı yapmamız lazım. callback fonksiyonumuz textChanged'a verdiğimiz closure yapısı ile aynı olmalı. Bir BindingTextField nesnesinde bu fonksiyonu kullanarak doğrudan text'i ViewModel içerisine View üzerinden binding edebileceğiz. yani bu yapı sayesinde View'ımızı viewModelimize bağlamış olacağız. 
        textChanged = callback
    }
    
    
    @objc func textFieldDidChange(_ textfield: UITextField) { //işlemi yapacak olan kısım, tetiklenme sonrsasında değişen texti alacak ancak bu fonksiyon çağrıldıktan sonra delege olması için yapmamız gereken şeyler var bunun bir yolu textChanged adında yazılmış olan closure.
        
        if let text = textfield.text {
            textChanged(text)
        }
    }
    
}
