//
//  User.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import Foundation
import FirebaseFirestore

struct User : Identifiable,Codable , Hashable{
    var id = UUID()
    var username: String
    var email : String
    var phoneno: String
    var image: String? = nil
    
    func toDictionary() -> [String: Any] {
            return [
                "id": id.uuidString,
                "username": username,
                "email": email,
                "phoneno": phoneno,
                "image": image
            ]
        }
    static func fromQueryDocumentSnapshot(_ document: QueryDocumentSnapshot) -> User? {
            guard
                let username = document["username"] as? String,
                let email = document["email"] as? String,
                let phoneno = document["phoneno"] as? String
            else {
                return nil
            }

            let image = document["image"] as? String

            return User(username: username, email: email, phoneno: phoneno, image: image)
        }
}

