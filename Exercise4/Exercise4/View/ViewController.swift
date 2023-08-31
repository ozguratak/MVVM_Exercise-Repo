//
//  ViewController.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    func dataDidLoad() {
        self.tableView.reloadData()
    }
    
    let listVM = DataViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listVM.requestData()
        setupBinding()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func setupBinding() {
        
        listVM.dataBinding.bind { [weak self] newData in
            self?.tableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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

