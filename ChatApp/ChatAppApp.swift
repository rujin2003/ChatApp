//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import SwiftUI
import FirebaseCore

@main
struct ChatAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Login(LoginviewModel: AuthDIContainer.shared.makeLoginViewModel(), SignupModel: AuthDIContainer.shared.makeSignUpViewModel())
            
        }
    }
}
