//
//  AddFreindViewModel.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import Foundation

import SwiftUI
import Combine

enum SearchState {
    case normal
    case loading
    case loaded
}

class AddFriendViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var state: SearchState = .normal
    @Published var searchResults: [User?] = []

    func searchForUsers( uservalue : String ) {
        
        DispatchQueue.main.async{
            self.state = .loading
        }
        Task{
            searchResults.append(try await  SearchUser.shared.searchUser(field: "username", value: uservalue))
        }
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
          
          
            DispatchQueue.main.async{
                self.state = .loaded
            }
        }
    }

    func resetSearch() {
        searchText = ""
        searchResults = []
        DispatchQueue.main.async{
            self.state = .normal
        }
    }
}
