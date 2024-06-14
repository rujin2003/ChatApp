//
//  SearchUser.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import Foundation
import FirebaseFirestore
class SearchUser: ObservableObject {
    
 static let  shared = SearchUser()
    
    

    func searchUser(field: String, value: String) async throws -> User? {
        let usersRef = Firestore.firestore().collection("Users")
        let query = usersRef.whereField(field, isEqualTo: value)

        do {
            let querySnapshot = try await query.getDocuments()

            guard let document = querySnapshot.documents.first else {
                print("nodata")
                return nil
                
            }

            if let user = User.fromQueryDocumentSnapshot(document) {
                print(user)
                return user
            } else {
                throw NSError(domain: "User decoding error", code: 0, userInfo: nil)
            }
        } catch {
            throw error
        }
    }

}
