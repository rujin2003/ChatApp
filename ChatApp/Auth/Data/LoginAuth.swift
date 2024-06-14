//
//  LoginAuth.swift
//  ChatApp
//
//  Created by Rujin on 12/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

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
    
    
    func getUserData() async throws -> User? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        let uid = currentUser.uid
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(uid)
        
        let document = try await docRef.getDocument()
        
        guard let data = document.data() else{
            return nil
        }
        
        let username = data["username"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let phoneno = data["phoneno"] as? String ?? ""
        let image = data["image"] as? String
        
        let user = User(
            username: username,
            email: email,
            phoneno: phoneno,
            image: image
        )
        print(user)
        
        return user
    }

}
