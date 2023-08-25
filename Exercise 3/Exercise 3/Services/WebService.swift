//
//  WebService.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation

struct Resource<T> { //Serviceten gelecek içeriklerin belirlenmesi için bir kaynapa ihtiyaç var. Bizim kaynağımız WebAPI'nin linkini ve bir data içeriyor. Data'yı ihtiyacımız olan tipteki veriye döndürebilmek için Resourcumuz T tipinde bir completion'a sahip
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice { // final class olarak tanımaldık amacımız herhangi bir değişim olmayacağını ve inherit olmayacağını ifade ediyoruz.
    /*load fonksiyonumuz tipi ile birlikte tanımlandı, completion handler'ımız datayı döndürebilmek için verildi.*/
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
                
            } else {
                completion(nil)
            }
            
        } .resume() //resume fonksiyonunun eklenme sebebi datanın gelmemesi durumunda ilk unutulan şey!
        
    }
    /* Load fonksiyonumuzu özetleyecek olursak, her zaman olduğu gibi bir url session data taskı belirledik. datataskın en büyük avantajı URL Error'leri doğrudan handle edebilir bir yapıya zaten sahip olması. iş yükümüzü hafifletir. data taskımızı resource structımız'ın url'i ile çalışması için set ettik. ardından data, response ve error completionlarımızı tnaıkmladık. data'yı binding ettik data geldiğinde main threadde çalışma olmayacağı için background threade girecek şekilde kuyruğa aldık ve ardından gene resource içinde belirttiğimiz data modeline cast edilmesi için resource'umuzun parse değişkenini kullandık. Böylece load fonksiyonumuzun içinde daha az kod yazmış olduk. */
}
