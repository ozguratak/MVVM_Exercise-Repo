//
//  ArticleViewModel.swift
//  Exercise1
//
//  Created by Özgür  Atak  on 15.08.2023.
//

import Foundation

struct ArticleListViewModel { // Sayfa yapımızda neyin nereden ne veri alacağını ifade edeceğimiz kısmı yaratıyoruz. Birden çok haber içeriği listeleyeceğimiz için aşağıda yarattığımız ArticleViewModel'i baz alacak biçimde birden çok article içeriğini, Article modeline referans alarak listelemiş biçimde bir liste yapısı yaratacağız. Bu sayede ArticleListViewModel yapımız ArticleViewModel'den referansla aldığı içerik yapısını, belirttiğimiz listeleme fonksiyonlarını kullanarak dolduracak ve görüntüyü yaratması için View'a iletecek.
    
    let articleList: [Article] //article modelinden gelecek olan bir article listesi yarattık.
}
// Listenin oluşturulmasının ardından tableView'ın kullanması için gerekli olan fonksiyonları ekliyoruz.
extension ArticleListViewModel { //Kaç sütun olacağı bilgisi
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int { //Kaç satır olacağı bilgisi
        return self.articleList.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel { //Article listesi içindeki indexe göre index bilgisi aktarımı
        let article = self.articleList[index]
        return ArticleViewModel(article)
    }
}

/*
 Alt kısımda yer alan ArticleViewModel yapısı, tek bir article hücresinin içeriğini tanımlar. Adım adım ilerleyecek olursak, ilk aşamada viewmodel için modeli tanımladık yani hangi model ile iletişimde olacağını ifade ettik. Ardından, iletişimde olduğu modelin içinden neleri nasıl ve neye göre alacağını tanımlamak için önce initilaze ettik hemen ardından nesnelerini tanımladık.
 */
struct ArticleViewModel { //Sadece Article göstermekle sorumlu olan viewmodel'i tanımlıyoruz ve modelinin ne olduğunu bildiriyoruz
    private let article: Article
}


extension ArticleViewModel { //Article gösterebilmesi için initilaze ediyoruz. Kısaca listelenecek olan veriyi nereden listeleyeceğini belirtiyoruz.
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel { //initilaze sonrasında içerikleri nereden alması gerektiğini ve neler olması gerektiğini ifade ediyoruz. Ayrıca, title ve description değerleri nullable değerler oldukları için eğer boş gelirlerse yerlerini tutacak alternatif metinlerde içine ekledik. Yani içeriklerin doldurulduğu yer haline getirdik.
    var title: String {
        if let title = self.article.title {
            return title
        } else {
            return "Title not found."
        }
        
    }
    
    var description: String {
        if let description = self.article.description {
            return description
        } else {
            return "Not found news content"
        }
    }
}
