//
//  DIContainer.swift
//  ChatApp
//
//  Created by Rujin on 05/06/24.
//

import Foundation
class AuthDIContainer {
    static let shared = AuthDIContainer()
    private init(){}
    
    lazy var loginService : LoginProtocol = {
        LoginAuth()
    }()
    
    lazy var signupService : SignupProtocol = {
        SignupAuth()
    }()
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(netLogin: loginService)
    }
    func makeSignUpViewModel()-> SignupViewModel{
        SignupViewModel(netsignup: signupService)
    }

    
}
