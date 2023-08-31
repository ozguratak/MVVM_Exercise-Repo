//
//  WebService.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

import Foundation

class WebService {
   static let shared = WebService()
    
    func load(url: URL?, completion: @escaping (Result<ModelList, NetworkError>) -> Void ) {
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    completion(.failure(.serverError))
                } else if let data = data {
                    let data = try? JSONDecoder().decode(ModelList.self, from: data)
                    if let list = data {
                        completion(.success(list))
                    } else {
                        completion(.failure(.parsingError))
                    }
                }
            } .resume()
            
        } else {
            completion(.failure(.urlError))
        }
    }
}

enum NetworkError: Error {
    case urlError
    case serverError
    case parsingError
}

struct URLService {
    var baseLink: String = "https://raw.githubusercontent.com/"
    var userName: String = "atilsamancioglu/"
    var query: String = "K21-JSONDataSet/master/crypto.json"
    
    static func urlGenerator() -> URL {
        if let url = URL(string: URLService().baseLink + URLService().userName + URLService().query) {
            return url
        }
        return urlGenerator()
    }
}
