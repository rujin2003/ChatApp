//
//  AddFreind.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import SwiftUI

struct AddFriend: View {
    @StateObject private var viewModel = AddFriendViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Add Friend")
                    .font(.system(size: 25))
                    .bold()
                    .padding()
                Spacer()
            }
            HStack {
                TextField("Search users...", text: $viewModel.searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                Button(action: {
                    viewModel.searchForUsers(uservalue: viewModel.searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 40, height: 40)
                        .background(Color(red: 93 / 255, green: 173 / 255, blue: 226 / 255))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding()

            Spacer().frame(height:100)
           
            switch viewModel.state {
            case .normal:
                Text("Enter a search query to find users.")
                    .foregroundColor(.gray)
                    .padding()
            case .loading:
                ProgressView("Searching...")
                    .padding()
            case .loaded:
                List(viewModel.searchResults, id: \.self) { user in
                    Text(user?.username ?? "no result found ")
                }
            }
            
            Spacer()

        }
        .padding()
    }
}

struct AddFriend_Previews: PreviewProvider {
    static var previews: some View {
        AddFriend()
    }
}
