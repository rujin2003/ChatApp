//
//  HomepageViewModel.swift
//  ChatApp
//
//  Created by Rujin on 13/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomePageViewModel : ObservableObject{
    
    @Published var userData : User = User(id: UUID(), username: "", email: "", phoneno: "", image: "")
    
    func getUserData() async throws -> Void {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let uid = currentUser.uid
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(uid)
        
        let document = try await docRef.getDocument()
        
        guard let data = document.data() else {
            print("data nai ayena")
            return
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
        
        DispatchQueue.main.async {
            self.userData = user
        }
    }
}
