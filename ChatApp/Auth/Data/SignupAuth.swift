//
//  SignupAuth.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//


import Foundation
import FirebaseAuth



class SignupAuth: SignupProtocol {
    static let shared = SignupAuth()
    
    func signupUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if authResult != nil {
                print(authResult?.user.email ?? "User instance is nil")
                completion(.success(()))
            }
        }
    }
}
