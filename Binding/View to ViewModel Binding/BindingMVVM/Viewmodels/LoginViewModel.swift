//
//  LoginViewModel.swift
//  BindingMVVM
//
//  Created by Özgür  Atak  on 25.08.2023.
//


//MARK: Login View Model
/*
 Oldukça basit ve az elemandan oluşan bir viewmodel yapacağız. Viewmodelimizin görevi Login ekranımızda kullanıcı tarafından girilen verileri almak ve gerekli yerlere iletişimini sağlamak olacak. zaten 2 tane veri tutacağı için class olarak yapmaya gerek yok. ek olarak structlar, class'larla benzer özelliklere sahip ayrıca memory leak için dah amakul çözümler. Swift'in nimeti olan structlardan faydalanmak lazım. 
 */
import Foundation

struct LoginViewModel {
    var userName: String = ""
    var password: String = ""
}
