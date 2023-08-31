//
//  Binding.swift
//  Exercise4
//
//  Created by Özgür  Atak  on 31.08.2023.
//

import Foundation
class Binding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func update(_ value: T) {
        listener?(value)
    }
}
