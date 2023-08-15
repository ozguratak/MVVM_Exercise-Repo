//
//  ArticleModel.swift
//  Exercise1
//
//  Created by Özgür  Atak  on 15.08.2023.
//

struct ArticleList: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Decodable {
    var title: String?
    var description: String?

}
