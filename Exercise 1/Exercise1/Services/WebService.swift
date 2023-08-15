//
//  WebService.swift
//  Exercise1
//
//  Created by Özgür  Atak  on 15.08.2023.
//

import Foundation

class Webservice {
    
    func getARtciles(url: URL, completion: @escaping ([Article]?) -> ()) {
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("urlSession Error : \(error.localizedDescription)")
                completion(nil)
            } else if let result = data {
                
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: result)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
                print(data)
                
            }
        } .resume()
      
    }
}
