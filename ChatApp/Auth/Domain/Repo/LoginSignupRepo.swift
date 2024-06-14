//
//  LoginSignupRepo.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import Foundation

protocol LoginProtocol{
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getUserData() async throws -> User? 
}

protocol SignupProtocol{
    func signupUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func uploadData(user: String ,mail: String ,no: String ,image: Data)-> Void
    func uploadImage(data: Data, completion: @escaping (String?) -> Void)
}
