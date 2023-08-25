//
//  WeatherListTableViewController.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 23.08.2023.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate {
    
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Units!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: String(describing: WeatherCellTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherCellTableViewCell.self))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        let defaults = UserDefaults.standard
        if let value = defaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Units(rawValue: value)!
        }
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
    }
    
}

extension WeatherListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCellTableViewCell.self), for: indexPath) as! WeatherCellTableViewCell
        
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        cell.layer.borderWidth = (cell.frame.width / cell.frame.height) + 2
        cell.configure(vm: weatherListViewModel.modelAt(indexPath.row))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSequeForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsViewController(segue: segue)
        }
    }
    
    func prepareSequeForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationCOntroller not found!")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("Adding page not found")
        }
        addWeatherCityVC.delegate = self
    }
    
    func prepareSegueForSettingsViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found!")
        }
        
        guard let settingsVC = nav.viewControllers.first as? SettingsViewController else {
            fatalError("Settings Page was not found!")
        }
        settingsVC.delegate = self // küçük ama çok önemli bir detay! delegate kendine bağlanmazsa tetikleyici çalışmaz!!!!
    }
}

extension WeatherListTableViewController: SettingDelegate {
    
    func settingsSaved(vm: SettingsViewModel) {
        if lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to: vm.selectedUnit)
            self.tableView.reloadData()
            lastUnitSelection = Units(rawValue: vm.selectedUnit.rawValue)!
        }
    }
}
