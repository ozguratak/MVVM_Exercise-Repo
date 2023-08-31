//
//  ViewController.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

//MARK: View Controller
/*
 ViewController sınıfı tüm örneklerde olduğu gibi sadece kullanıcıya içeriği göstermekle yükümlü olan kullanıcı arabirimini (UI) oluşturan controllerımız. Bu controller basitçe sıralayacak olursak; verilerin referansı olacak bir ViewModel nesnesi, Verilerin güncellenmesi durumundan haberdar olabileceği bir Binding fonksiyonu ve Verilerin listelenerek kullanıcıya sunulacağı basit bir TableView nesnesinden oluşuyor.
 
 Temel olarak basit 3 bileşen ile ViewControllerımız üzerinde bulunan table view nesnesini Binding fonksiyonunu kullanarak ViewModel içeriğini referans alacak biçimde kullanıcıya sunuyoruz diyebiliriz.
 */

import UIKit

class ViewController: UIViewController {
    
    let listVM = DataViewModel() // ViewModel listemizi controllerımızın içine initilaze ettik. artık listVM typeallias'ını kullanarak ViewModelimizin içinde tanımlı olan bir çok işlemi kontrol edebiliriz.
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listVM.requestData() // İlk olarak tabiki API üzerinden gelecek olan datayı almamız gerekiyor. Bunun için ViewModelimizin içerisinde tanımladığımız ve verileri alacak olan requestData() fonksiyonumuzu çalıştırıyoruz.
        setupBinding() // Datalarımız bir önceki satırda çağrılan fonksiyon sayesinde API üzerinden alındı fakat bu işlem asenkron olarak gerçekleşiyor ve hat aoluşturabilir. Hata oluşmasa dahi verilerimiz asenkron bir biçimde yüklendiği için View üzerinde yer alan table View nesnesinin güncellenmesi bizim için bu aşamada bir sorun. Bu yüzden, ViewModel'de veirler requestData() fonksiyonu ile çağrıldığında tableView içeriğinin güncellenmesi için veriyi "bağlamamız" gerekiyor. Detaylı anlatımını Controllers klasörü altında bulunan Binding sınıfı içerisindeki commentlerde bulabiliriz.
        tableView.delegate = self
        tableView.dataSource = self // tableView nesnemizi View'ımızın içine delege ettik ve datasourceunu belirttik. artık veirlerimiz yüklenmeye ve gösterilmeye hazır.
    }
    
    
    private func setupBinding() { // Binding fonksiyonu ViewModelimiz içerisinde yer alan bir dataBinding fonksiyonuna bağlı olarak çalışıyor ve veri olmadığı durumda weak olarak tanımlandığı için memoryde yer tutmuyor. Ancak, requestData fonksiyonunun tetiklenmesi ile Modelimiz artık bir içeriğe sahip olduğu için ViewModelimizi de güncelliyor ve bir şekilde bizim de View'ımızı güncellememiz gerekiyor. View'ımız göstereceği içerikleri ViewModelden alacak. ViewModel ise veriyi WebService kullanarak asenkron bir biçimde API'den çekecek. ViewModel'in artık bir içeriğe sahip olduğunu View'ımız binding yapısı sayesinde öğrenecek ve bu güncelleme ile tableView'ımızı reload edecek. Eğer bir pagination yapısı veya tüm verinin tek seferde çekilip parça parça gösteirlmesi gibi bir yapı uygulanması gerekirse bu yapı da ViewModel içerisinde veya WebService içerisinde uygulanmalı.
        
        listVM.dataBinding.bind { [weak self] newData in
            self?.tableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource { // TableView nesnesi için gerekli olan delegate ve datasource protocollerinin gerekli fonksiyonlarının tanımlanması. 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = listVM.list[indexPath.row].currency!
        content.secondaryText = listVM.list[indexPath.row].price!
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.list.count
    }
}

