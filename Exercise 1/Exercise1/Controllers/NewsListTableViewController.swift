//
//  NewsListTableViewController.swift
//  Exercise1
//
//  Created by Özgür  Atak  on 15.08.2023.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad() //Eğer, ilk aşamada yer almazsa class'ımızı türettiğimiz TableViewController düzgün yüklenmeyecektir.
        
        setup() //sadece classımız tarafından erişlebilir olan bir private fonksyion yarattık. Bu fonksiyon, viewdidload işlemi tamamlandıktan sonra devreye girecek ve UI'ımızı ayarladığımız şekilde yapılandırılmasını sağlayacak
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true // Setup fonksiyonumuzun ilk görevi navigation bar üzerinde yer alan GoodNews isimli başlığımızın büyük bir biçimde yazılmasını sağlamak,
        // self.navigationController?.navigationBar.backgroundColor = .gray // İkinci aşama olarak title'ın background rengini buradan ayarlayabiliriz fakat burada yaptığımız ayarlama sadece bu viewmodel için geçerli olur. Genel ayarlar için AppDelegate üzerinden bu işlemi gerçekleştireceğiz.
        
        //Servis çağrısına çıktığımız yer aşağıda, url path'imizi verdik. Ardından webservice.getarticle fonksiyonumuzu çalıştırarak gelen JSON datasını Article modeline göre cast ettik. response hata atmazsa main thread içinde table view'ı reload ediyoruz.
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=317246083c5d4a87822a434a845a7ad0")!
        Webservice().getARtciles(url: url) { result in
            if let articles = result {
                self.articleListVM = ArticleListViewModel(articleList: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: TableView Settings
    //Burada table view için gerekli ayarlarımızı yapıyoruz. bunları yaparken çağrı sonucuna bağlı olarak boş veya dolu göstermek için ilk aşamada çağrı sonucunu bekliyoruz. ardından çağrı ile dolmuş olan articleListVM yani ViewModel yapımız section sayısını alıyor ardından satırdaki section değerini alıyor ve en sonunda ArticleTableViewCell olarak isimlendirilen prototip cell ViewModelden gelen data ile yapılandırılıp içeriği dolduruluyor.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("Article Cell Was Not Found!")
            
        }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        return cell
    }
}
