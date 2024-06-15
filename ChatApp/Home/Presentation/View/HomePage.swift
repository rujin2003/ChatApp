//
//  HomePage.swift
//  ChatApp
//
//  Created by Rujin on 13/06/24.
//

import SwiftUI

struct HomePage: View {
    @StateObject var homeModel = HomePageViewModel()
    @StateObject var imageDownloadViewModel = ImageDownloadViewModel()

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
                        .clipShape(Circle()).padding()
                } else {
                    ProfilePicWidget(viewModel: imageDownloadViewModel, imageURL: homeModel.userData.image ?? "").padding()
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
                
                if let imageURL = homeModel.userData.image {
                    await imageDownloadViewModel.fetchImage(url: imageURL)
                }
            }
        }
    }
}

#Preview {
    HomePage()
}
