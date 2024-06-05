//
//  LoginSignupRepo.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import Foundation

protocol LoginProtocol{
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol SignupProtocol{
    func signupUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}
