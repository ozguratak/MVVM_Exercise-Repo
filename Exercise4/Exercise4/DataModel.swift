//
//  Model.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

import Foundation

struct Model: Codable {
    var currency: String?
    var price: String?
}

typealias ModelList = [Model]?
