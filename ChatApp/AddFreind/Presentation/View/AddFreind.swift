import SwiftUI
import Firebase

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
                }
                .padding(.trailing, 10)
            }
            .padding()

            Spacer().frame(height: 30)
           
            switch viewModel.state {
            case .normal:
                Text("Enter a search query to find users.")
                    .foregroundColor(.gray)
                    .padding()
            case .loading:
                ProgressView("Searching...")
                    .padding()
            case .loaded:
                if viewModel.searchResults.isEmpty {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.searchResults) { user in
                        AdduserWidget(user: user, imageDownloadViewModel: HomeDiContainer.shared.makeImageViewModel()) {
                        Task{
                            await   AddUser.shared.addUser(username: user.username ,phoneno: user.phoneno, image: user.image ?? "no image")
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 5)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
    
   
}

struct AddFriend_Previews: PreviewProvider {
    static var previews: some View {
        AddFriend()
    }
}

