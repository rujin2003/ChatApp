//
//  SignupAuth.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.


import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation

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

    func uploadImage(data: Data, completion: @escaping (String?) -> Void) {
        let storage = Storage.storage().reference()
        let imageData = data
        let path = "image/\(UUID().uuidString).jpg"
        let file = storage.child(path)

        file.putData(imageData, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                file.downloadURL { url, err in
                    if let err = err {
                        print("Failed to get the URL: \(err.localizedDescription)")
                        completion(nil)
                        return
                    }
                    completion(url?.absoluteString)
                }
            } else {
                print("Failed to upload image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }

    func uploadData(user: String, mail: String, no: String, image: Data) {
        uploadImage(data: image) { url in
            guard let imageUrl = url else {
                print("Failed to upload image")
                return
            }
            let user = User(username: user, email: mail, phoneno: no, image: imageUrl)

            let db = Firestore.firestore()
            let currentUser = Auth.auth().currentUser
            db.collection("Users").document(currentUser?.uid ?? mail).setData(user.toDictionary()) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
}
