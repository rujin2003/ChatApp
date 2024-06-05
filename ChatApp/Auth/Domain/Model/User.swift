//
//  User.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import Foundation

struct User : Identifiable,Codable {
    var id = UUID()
    var username: String
    var email : String
    var password : String
    var phoneno: String
    
}
