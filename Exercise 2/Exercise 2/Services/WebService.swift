//
//  WebService.swift
//  Exercise 2
//
//  Created by Özgür  Atak  on 16.08.2023.
//

import Foundation

/*
 Projenin ilk aşamasında sadece veri çeken bir load fonksiyonumuz vardı. Tek bir link üzerinden tek bir method olan get metodu ile işlem yapmaktaydı. Ancak, projenin ikinci aşamasına gelindiğinde post edilmesi gereken modelimizi webAPI'ye iletebilmek için bazı değişiklikler yapmamız gerekti. Sırasıyla bu değişiklikler şu şekilde oldu;
 
 1- Resource struct'ının yeninden düzenlenmesi; Resource struct'ı ilk başta Codable olarak modellenebilir bir yapıyı referans tutarak çalışmasına rağmen sadece bir url değişkeni barındırmaktaydı. ancak bu url ile yapacağı get işlemi load fonksiyonu tarafından atanmakta ve ona göre işlem yapmaktaydı. Post işlemlerini yapabilmek için order üzerinde bir extension açtık ve bu extension'ı kullanarak yeni bir post yeteneğine sahip resource yarattık.
 
 2- REsource tanımlaması bittikten sonra Order modelimize teni bir extension ekleyerek post işleminin gereksinimlerini karşılayacak düzenlemeleri yaptık. Akabinde webService yapısına ait load fonksiyonumuzda bir kaç modifikasyona gittik. çünkü resource parametresinde yapılan bazı değişiklikler httpbody, method gibi yeni parametrelerin belirtilmesini gerektirdi. Bu eklentiyi tamamlamadan önce, load fonksiyonumuz o ana kadar yapılan order eklentisi içindeki create yapısıyla, order'ın tekrar encode edilmesiyle falan hiç ilgilenmiyordu.
 
 3- POST işlemlerimizi ise AddOrderViewCOntroller içerisinde yer alan IBAction saveButtonTapped fonksiyonunda gerçekleştireceğiz. 
 
 */
extension Order { //1. maddede tanımlanmış olan post yapısını sağlayan extension.
    
    static var all: Resource<[Order]> = { //bunu load fonksiyonunu çağırdığımız ilk sayfaya ait viewcontroller içerisinde bulunan resource tanımlamasını kaldırmak için tanımladık. daha önce orada bir link tanımlaması yapılmıştı ardındna bu link resource olarak belirtilmişti. artık ona gerek kalmadı, direkt olarak load fonksiyonunun parametresi olan resource için Order.all kullanarak aynı işlemi yapabilir hale getirdik. Amaç clean code

        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: NewOrderViewModel) -> Resource<Order?> { //Order tipinde veri alan bir resource oluşturacak fonksiyonumuz
        let order = Order(vm) //Order viewmodel'ini referans tutan bir order değişkeni tanımladık.
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else { //post edilecek olan url'imizi kontrollü biçimde atadık.
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else { //order modelimizi JSON Dataya encode ederek oluşturduk. Artık data adında JSON tipinde order verimiz var şimdi bunu post etmemiz lazım.
            fatalError("Encoding Error!")
        }
        
        var resource = Resource<Order?>(url:url) //optional order tipinde bir resource değişkeni tanımladık ve bu resource'a bir link bağladık.
        resource.httpMethod = HTTPMethod.post //post işlemini yapabilmek için httpMethodumuzu seçtik.
        resource.body = data //post edilecek olan body'i tanımladık. body'miz tabiki JSON olarak encode ettiğimiz order modelimiz.
        
        // Resource yapısı içersinde http method seçme bve body ekleme kabiliyetlerimize olanak sağlayan şey, aşağıdaki Resource struct'ı içerisinde httpMethod ve data gibi priorityler tanımlamış olmamaız ve bunları initilaze edebileceğimiz bir init yapısı eklemiş olmamız oldu.
        
        return resource // fonksiyonumuz, linki olan, methodu belli, body'si belli herşeyiyle hazır bir JSON data oluşturdu ve bunu döndü.
    }
}

struct Resource <T: Codable> { /*resource yapımız codable bir tipe sahip. default olarak bir url içerir httpmetodu get'tir null data bulundurur. Bunları tanımlamamızın sebebi, webAPI'ye bir şey post edecek olmamız. Post edilecek olan bir veriyi tanımlayabilmek için bir link, bir httpMethod ve tabiki bir dataya ihtiyacımız var.
    
    Eğer post işlemi değilde sadece get yapacaksak verinin decode edileceği model ve verinin geleceği link'i tanımlamak zaten yeterli. */
    let url: URL
    var httpMethod: HTTPMethod = .get
    var body: Data? = nil
    
    //Ancak, sadece bunları tanımlamış olmak post işlemini yapaiblmek için yeterli değil. default'da tanımlı olan değerlerimiz nil bir data ve get işlem yeteneği. Bizim gerekli yerde load fonksiyonu aracılığı ile post işlemi yapaiblmemiz için bu REsource yapısının initilaze edilebilmesi gerekiyor bu yüzden hızlıca ufak bir init yeteneği ekleyerek resource yapımıza bu özelliği kazandırıyoruz. 
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in //2. maddede ifade edilmiş olan yenilikler sonrasında ilk başta doğrudan url'i alarak çalışan load fonksiyonu artık bir request modeli alarak ilerliyor. link aynı, resource içinden gelen method tanımlandığı için reuqest üzerinde bir method, bir body belirtmemiz gerekiyor. body zaten default olarak nil tanımlı. methodumuzun default değeri get. requestin diğer eksikleri header ve value, onları da direkt fonksiyon içinde tanımladık. geri kalan kısımlar zaten gelen verinin decode edilmesi ve GCD üzerinden tableView'a eklenecek olan modelin doldurulmasından ibaret.
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    
    
}
