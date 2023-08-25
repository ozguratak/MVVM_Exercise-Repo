//
//  String+Extensions.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation

extension String {
    
    func escaped() -> String { // Los Angles gibi arasında boşluk olan şehir isimlerini url tipine uyguyn bir biçimde düzenleyecek olan extension
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    
}
