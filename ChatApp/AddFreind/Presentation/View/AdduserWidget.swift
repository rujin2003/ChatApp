import SwiftUI

struct AdduserWidget: View {
    var user: User
    @StateObject var imageDownloadViewModel: ImageDownloadViewModel
    var addUserAction: () -> Void
    
    @State private var isFriend = false
    
    var body: some View {
        HStack {
            ProfilePicWidget(viewModel: imageDownloadViewModel, imageURL: user.image)
            
            Text(user.username)
                .font(.system(size: 20))
                .bold()
                .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                addUserAction()
            }) {
                Image(systemName: isFriend ? "person.fill.checkmark" : "person.badge.plus.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(isFriend ? .green : .blue)
            }
            .padding(.trailing, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .onAppear {
            checkIfFriend()
        }
    }
    
    private func checkIfFriend() {
 
        isFriend = false
    }
}

//struct AdduserWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        AdduserWidget(user: User(id: UUID(), username: "John Doe", email: "john@example.com", phoneno: "1234567890", image: "https://www.example.com/image.jpg"), imageDownloadViewModel: ImageDownloadViewModel()) {
//            // Action handler
//        }
//    }
//}

