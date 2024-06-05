//
//  LoginAuth.swift
//  ChatApp
//
//  Created by Rujin on 03/06/24.
//

import Foundation
import FirebaseAuth



class LoginAuth : LoginProtocol{
    static let shared = LoginAuth()
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if authResult != nil {
                print(authResult?.user.email ?? "User instance is nil")
                completion(.success(()))
            }
        }
    }
}
