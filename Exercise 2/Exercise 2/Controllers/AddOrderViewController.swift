//
//  AddOrderViewController.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 16.08.2023.
//

import Foundation
import UIKit


protocol AddOrderDelegate { //Yeni oluşturulan orderlarımızı ana ekran view'ımızda görüntüleyebilmek için bir protokol yazıyoruz.
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeOrderViewControllerDidClose(controller: UIViewController)
}

/*
 Protocolün yazılma nedeni: Add orderDelegate protokolünün görevi, yeni order işleminde save sürecinin api tarafına iletilmesi neticesinde dönen success mesajına yön vererek oluşturulan order'ın orders isimli ana sayfada güncelleme yapmasını sağlar. Ek olarak, didClose fonksiyonu, protokol bütününde eklenerek daha esnek bir süreç yönetimi yapılmasını sağlamaktadır.
    
Elbetteki close butonuna doğrudan dismiss fonksiyonu eklenebilir ancak bunu yönetmesi gereken yapı yeni order oluşturulan addOrderViewController'ıdır. Bunu doğrudan yapmak yerine esnek yapıyı tercih etmek daha uygun bir özellik.
*/

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate: AddOrderDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.addCoffeOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func SaveButtonTapped(_ sender: Any) { //Save butonuna basıldığında; name, email textfieldlarından alınan veriler ve segment controlden gelen data ile table view'ın seçili indexine ait string değeri değişken olarak memory'e eklenirler. ardından bu değerler ViewModel'e dönüştürülmek üzere gerekli adrese iletilir.
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let size = self.coffeSizesSegmentedControl.titleForSegment(at: self.coffeSizesSegmentedControl.selectedSegmentIndex)
        guard let cofferTypeIndex = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selected coffe!")
        }
        
        self.vm.name = name //direkt tanımladığımız textField'dan geliyor
        self.vm.email = email //direkt tanımladığımız textField'dan geliyor.
        self.vm.selectedSize = size //View içinde bulunan, programaticUI ile eklenmiş segment controller'a ait herhangi bir segment adını, gene aynı segmentin seçili olan indexinden alarak getiriyor.
        self.vm.selectedType = self.vm.types[cofferTypeIndex.row] // view'da tanımlı olan tableView üzerindeki seçili olan cell'in index numarasını getiriyor.
        
        //Buraya kadar olan aşamada bir view modeli referans alarak model yaratma işini yaptık. yani model-ViewModel arasındaki talkto işlemini aslında ters akışta gerçekleştirdik. ViewModel üzerinde yapılan değişimler ile bir model geliştirdik. Şimdi bu model'imizi post etmek için gerekli düzenlemeleri yapacağız. Bunlar; Webservice içerisinde yer alan load fonksiyonumuza yeni yetenekler ekleyerek HttpMethodlarından olan get ve post metodlarının seçilebilir bir biçimde olması olacak. Bu yeteneği kullanarak load fonksiyonumuzla yarattığımız modeli post edeceğiz.
        
        Webservice().load(resource: Order.create(vm: self.vm)) { result in
            /* Webservice içinde tanımlı olan Order extension'ı ile oluşturulmuş "create" isimli static fonksiyonu resource olarak atadık. Create fonksiyonu bizden bir model istiyor, bu modelimiz View'dan alınan bilgilerle içeriği oluşturulan vm isimli ViewModelimiz. ViewModelimizi daha önce NewOrderViewModel olarak tanımlamıştık ve teknik alt yapısı en başta kurgulanan order modeli ile oldukça benzer.
                                                                            
            Bu sayede az önce yapılandırdığımız viewmodelimizi JSON data olarak encode edebildik. ayrıca, load fonksiyonuna sonradan kazandırdığımız request becerisi sayesinde Order.create içerisinden alınan resource yapısına referans alınarak httpmethod ve body işlemlerimizide kendiliğinden halletmiş olduk. Buradan sonrası tableview'ın güncellenerek yeni order'ın */
            
            switch result {
            case .success(let order):
                
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var vm = NewOrderViewModel()
    private var coffeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupUI() { //Programatic UI örneği olarak segmentedControl butonu ekledik. ilk önce yukarıda butonun protokol olarak değişken tanımlamasını yaptık, fonksiyon içinde priorityleri nereden alacağını tanımladık. ardından autoresize özelliğini disable ettik. View'ımızın içine subview olarak ekledik. ardındna constraintlerini belirledik. ilk önce segmentedcontrol'ün üst bandını tableView'ın alt bandına ekledik ve 20 boşluk verdik. 2. aşama olarak X ekseninde merkezle dedik ve sağ sol yerleşimini belirledik.
        
        self.coffeSizesSegmentedControl = UISegmentedControl(items: self.vm.sizes)
        self.coffeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeSizesSegmentedControl)
        self.coffeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

extension AddOrderViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // Seçili hücre için tik işareti koyar.
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none // Seçili olmayan hücreden tik işaretini kaldırır.
    }
    
}
