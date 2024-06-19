//
//  Adduser.swift
//  ChatApp
//
//  Created by Rujin on 19/06/24.

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AddUser {
    static let shared = AddUser()
   
    func addUser(username: String, phoneno: String, image: String) async -> Bool {
        let friendData = [
            "username": username,
            "phoneno": phoneno,
            "image": image
        ]
        
        do {
            guard let currentUser = Auth.auth().currentUser else {
                print("User is not authenticated.")
                return false
            }
            
            let db = Firestore.firestore()
            let userRef = db.collection("Users").document(currentUser.uid)
            let friendRef = userRef.collection("Friends").document()
            
           
            let existingFriendSnapshot = try await friendRef.getDocument()
            
            if existingFriendSnapshot.exists {
                print("Friend already exists.")
                return false
            } else {
             
                try await friendRef.setData(friendData)
                print("Friend added successfully.")
                return true
            }
        } catch {
            print("Error adding friend: \(error.localizedDescription)")
            return false
        }
    }


}
