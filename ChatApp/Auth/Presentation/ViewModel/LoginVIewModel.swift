//
//  LoginVIewModel.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.



import Foundation
import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var logedIn : Bool = false
    
    let networkLogin : LoginProtocol
    init(netLogin : LoginProtocol){
        networkLogin = netLogin
    }
        
    func loginUser() {
        guard !username.isEmpty && !password.isEmpty else {
            alertMessage = "Please enter both username and password"
            showAlert = true
            return
        }
      
        LoginAuth.shared.loginUser(email: username, password: password) { result in
            switch result {
            case .success:
                self.logedIn = true
                print("Login successful")
                
            case .failure(let error):
             
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            }
        }
    }
}
