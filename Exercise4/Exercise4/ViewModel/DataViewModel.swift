//
//  DataViewModel.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

//MARK: ViewModel
/*
 ViewModel nesnesi, View için gerekli olan verileri indirebilir, güncelleyebilir, silebilir veya veriyi oluşturabilir. Bu projemizde verilerimiz bir API üzerinden alınıyor ve Model ile cast ediliyor(yani JSON verisini alarak ihtiyacımız olan veri tiplerine göre decode edip yapılandırıyoruz.) ardından gelen verilerimizi anlamlı hale getirdikten sonra (JSON decoding) bir model tipinde birden çok olan veriyi bir diziye ekliyoruz. Bu sürecin WebService sınıfı içerisinde URLSession kullanılarak yapıldığını düşünecek olursak verinin asenkron geldiği gerçeğini unutmamız gerekir, işte bu nedenle veriyi bir diziye dönüştürme işini asenksron biçimde sürdürmemiz gerekiyor.
 
 Verilerimizi bir dizi haline getirdikten sonra View'ımızın bu durumdan haberdar olabilmesi ve TableView nesnesini güncelleyebilmesi için Binding sınıfında oluşturduğumuz update fonksiyonumuzu kullanarak verimizi güncelliyoruz.
 
 ViewModelimizin, View'ı güncellemek ve bu durumdan haberdar olmasını sağlamak için dizi oluşturma işlemimiz bittikten sonra binding yaparak View'ın güncellenmesini sağlıyoruz. Zaten View sürekli olarak binding fonksiyonu sayesinde ViewModel ile iletişim hlainde olduğu için kendini güncelleyecektir.
 
 UIKit kullanımında binding uygulamak arkaplanda tableView nesnesini sürekli günceller. Bu durum kompleksli yapılarda hatalara ve memoryleaklere yol açabilir. bunu engellemek için doğru uygulama Protocol ve Delegate kullanmaktır. bu sayede gerektiği zamanlarda gerektiği durumlarda bir tetikleme yöntemiyle verinin güncellenmesi sağlanabilir. 
 */


import Foundation


class DataViewModel {
    
    let service = WebService.shared
    let url: URL = URLService.urlGenerator()
    var list = [Model]()
    var dataBinding = Binding<ModelList>()
    
    func requestData() {
        service.load(url: url) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    if let result = result {
                        for item in result {
                            self.list.append(item)
                        }
                        self.dataBinding.update(self.list)
                    }
                }
                
            case .failure(let failure):
                print(failure)
                
            }
        }
    }
}

