//
//  ViewController.swift
//  BindingMVVM
//
//  Created by Özgür  Atak  on 25.08.2023.
//


//MARK: Binding Nedir?
/*
 
Binding, kelime anlamı olarak <Bağlamak>, <Bağlayıcı> olarak çevrilebilir. MVVM Tasarım Örgüsü içerisinde View ve ViewModel arasında kopartılamaz bir iletişim yapısı bulunmaktadır. Bu iletişim yapısı ViewModel(VM) üzerinden gelen veriyi View(V)'a veya V üzerinden gelen veriyi VM'e aktarmak için oluşturacağımız yapıyı Binding olarak tanımlarız. Bunu daha anlaşılır hale getirmek için bir ekran oluşturalım ve ekranımızın içerisinde 2 tane text field olsun. Bu örnekte binding'in View to ViewModel bingingde nasıl çalıştığını daha net bir şekilde kavrayacağız.
 
Hap Bilgi: Binding, SwiftUI üzerinde default olarak tanımlı bir yapıdır. EnviromentBinding, StateBinding gibi isimlerle kullanılır. SwiftUI'da sayfalar arası veri aktarımlarını zaten binding ile yapmak gerekir. Ancak UIKit için aynı durum geçerli değildir.
 
DipNot: Projemizde pratik olması için progrmatik olarak bir arayüz tasarımı yapacağız.
 
 */

import UIKit

class ViewController: UIViewController {
    
    private var loginVM = LoginViewModel() // View modelimizin içerisine textFieldlarımızdan gelen verileri populate edeceğiz. Bunu yapmanın yollarından birisi textField için yazma işlemi bittiğinde bir veriyi almak gibi sıralı bir işlem mekanizması olabilir. bu nedenle BindingTextField isimli bir class oluşturacağız ve UITextField'a yeni yetenekler ekleyeceğiz. 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    @objc func login() {
        print(loginVM.userName)
        print(loginVM.password)
    }
    
    private func setupUI() { // SetupUI fonksiyonumuz, 2 adet textField ve 1 adet butonun ayarlamalarını yaptı. ardından bir verticilar stack view ekledik ve stack view'a constraintlerini belirledik. böylece UI işimiz bitmiş oldu. Ancak, doğrudan UITextField nesnesi kullanmak yerine UITextField'dan türettiğimiz ve adı BindingTextField olan bir textfield kullanıyoruz. Bunu yapma amacımız, text field içinde bir değişiklik olduğunda bir akış düzeni içerisinde viewmodelimizi kendi kendine güncellemek. BindingTextField, text değiştiğinde
        
        let userNameTextField = BindingTextField()
        userNameTextField.placeholder = "Enter Username"
        userNameTextField.backgroundColor = UIColor.lightGray
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.bind { [weak self] text in //Binding işlemi bu aşamada gerçekleşiyor. UITextField'dan türettiğimiz BindingTextField nesnemizi viewmodelimize kolayca bağlamak için sadece birbirine eşitlememiz yeterli oldu. ek olarak weak bağlamını kullanarak metin oluşmadıkça memoryde yer tutmamış olduk. 
            self?.loginVM.userName = text
        }
        
        let passwordTextField = BindingTextField()
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = UIColor.lightGray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.bind { [weak self] text in
            self?.loginVM.password = text
        }
        
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        
        
        self.view.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

}

