import SwiftUI

struct HomePage: View {
    @StateObject var homeModel: HomePageViewModel
    @StateObject var imageDownloadViewModel: ImageDownloadViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Welcome \(homeModel.userData.username)")
                    .font(.system(size: 25))
                    .padding()
                    .bold()
                Spacer()
                if homeModel.isLoading {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                        .padding()
                } else {
                    if let imageURL = homeModel.userData.image,
                       !imageURL.trimmingCharacters(in: .whitespaces).isEmpty {
                        ProfilePicWidget(viewModel: imageDownloadViewModel, imageURL: imageURL)
                            .padding()
                    } else {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .overlay {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                            .padding()
                    }
                }
            }
            Spacer()
            VStack {
                ScrollView {
                    ForEach(0...10, id: \.self) { _ in
                        ChatUser()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                try await homeModel.getUserData()
                
                if let imageURL = homeModel.userData.image,
                   !imageURL.trimmingCharacters(in: .whitespaces).isEmpty {
                    await imageDownloadViewModel.fetchImage(url: imageURL)
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(homeModel: HomeDiContainer.shared.makeHomePageViewModel(), imageDownloadViewModel: HomeDiContainer.shared.makeImageViewModel())
    }
}

