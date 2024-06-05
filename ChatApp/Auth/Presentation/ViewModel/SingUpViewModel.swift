//
//  SingUpViewModel.swift
//  ChatApp
//
//  Created by Apple on 04/06/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

class SignupViewModel: ObservableObject {
    @Published var textFieldState: String = "Username"
    @Published var textFieldStateValue: String = ""
    @Published var email: String = ""
    @Published var signupStateCounter: Int = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var signedUp: Bool = false
    
    private let signupStateManager = ["Email", "Phoneno", "Password"]
    
    
    let networkSignup : SignupProtocol
    init(netsignup : SignupProtocol){
        networkSignup = netsignup
    }
        
    
    func performPasswordAction(completion: @escaping (Bool) -> Void) {
        let password = textFieldStateValue
        
        SignupAuth.shared.signupUser(email: email, password: password) { result in
            switch result {
            case .success:
                print("Signup successful")
                completion(true)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                completion(false)
            }
        }
    }
    
    func advanceSignupState(completion: @escaping () -> Void) {
        if textFieldState == "Password" {
            performPasswordAction { success in
                if success {
                    self.signedUp = true
                    completion()
                }
            }
        } else {
            if textFieldState == "Email" {
                email = textFieldStateValue
            }
            textFieldStateValue = ""  // Clear the text field value
            textFieldState = signupStateManager[signupStateCounter]
            signupStateCounter = (signupStateCounter + 1) % signupStateManager.count
            completion()
        }
    }
}


