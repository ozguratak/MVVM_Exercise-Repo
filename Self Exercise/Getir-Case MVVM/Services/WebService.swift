//
//  WebService.swift
//  Getir-Case MVVM
//
//  Created by Özgür  Atak  on 8.09.2023.
//

import Foundation

class WebService {
    static let shared = WebService()
    
    func load(url: URL?, completion: @escaping (Result<ProductListModel, NetworkError>) -> Void) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    completion(.failure(.urlSessionError))
                } else if let data = data {
                    let data = try? JSONDecoder().decode(ProductListModel.self, from: data)
                    if let list = data {
                        completion(.success(list))
                    } else {
                        completion(.failure(.parsingError))
                    }
                }
            }.resume()
        } else {
            completion(.failure(.urlError))
        }
    }
    
}

enum NetworkError: Error {
    case urlSessionError
    case parsingError
    case urlError
}
