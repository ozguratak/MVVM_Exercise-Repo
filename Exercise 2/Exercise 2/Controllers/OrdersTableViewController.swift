//
//  OrdersTableViewController.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 16.08.2023.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddOrderDelegate { //View'ımız bir table view içerdiği için tableviewcontroller protokolüne uygun bir yapı dizayn ederek başlamamız gerekiyor.
    
    var orderListViewModel = OrderListViewModel() //ViewModel'imizi View'ımıza initilaze ettik. Bu sayede ViewModel - View arasındaki iletişimi başlatmış olduk.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders() //Uygulamamız yüklendiğinde servise get metoduyla çağrıya çıkmak için sorgulama fonksiyonumuzu yazıyoruz.
    }
    
    func addCoffeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
    
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    private func populateOrders() {
        
        Webservice().load(resource: Order.all) { result in
            switch result {
            case .success(let orders):
                self.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init) //Servisten gelen cevapın success olması durumunda, View'a initilaze ettiğimiz ViewModelimizin orderViewModel Arrayini mapleyerek dolduruyoruz. ardından tableView'ımızı reload ediyoruz ki ekranda içerikleri görebilelim.
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
        let addCoffeOrderVC = navigationController.viewControllers.first as? AddOrderViewController else {
            fatalError("Error for segue")
        }
        
        addCoffeOrderVC.delegate = self
    }
    
        
    
    //MARK: TableView Protokol gereksinimini karşılayacak olan yapı düzen fonksiyonları
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Delegate fonksiyonu tanımlaması,
        
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row) // Cell'e ait viewModel verisi, orderViewModel içinde tanımlanmış olan TEK BİR ORDER için olan fonksiyonu çağırarak model tanımlamasını yaptık. çünkü her bir cell tek bir order'ı listeleyecek. TableView yapısı bir loop içinde indexpath.row değerine göre hareket ettiği için her seferinde array içinde ilgili indexte yer alan veriyi cell için kullanacak.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) // Kullanacağımız cell'i reusable cell tanımlaması yaparak belirttik.
            
        cell.textLabel?.text = vm.type // yukarıda vm olarak tanımladığımız order'a ait olan ViewModel'den gelen veriyi Cell View için neresine ne yazacaksa onu ifade edecek biçimde belirttik.
        cell.detailTextLabel?.text = vm.size
        
        return cell
        
    }
    
} // End Of View
