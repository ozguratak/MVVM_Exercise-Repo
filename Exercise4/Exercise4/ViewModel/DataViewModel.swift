//
//  DataViewModel.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

import Foundation


class DataViewModel {
    
    let service = WebService.shared
    let url: URL = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
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

