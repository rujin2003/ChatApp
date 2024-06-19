//
//  AddFreindViewModel.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import Foundation
import FirebaseFirestore

class AddFriendViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [User] = []
    @Published var state: ViewState = .normal
    
    enum ViewState {
        case normal
        case loading
        case loaded
    }
    
    func searchForUsers(uservalue: String) {
        guard !uservalue.isEmpty else { return }
        self.state = .loading
        
        Task {
            do {
                if let user = try await SearchUser.shared.searchUser(field: "username", value: uservalue) {
                    DispatchQueue.main.async {
                        self.searchResults = [user]
                        self.state = .loaded
                    }
                } else {
                    DispatchQueue.main.async {
                        self.searchResults = []
                        self.state = .loaded
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.searchResults = []
                    self.state = .normal
                }
                print("Error searching for users: \(error)")
            }
        }
    }
}
