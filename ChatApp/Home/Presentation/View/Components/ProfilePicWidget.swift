//
//  ProfilePicWidget.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import SwiftUI

struct ProfilePicWidget: View {
    @ObservedObject var viewModel: ImageDownloadViewModel
    let imageURL: String
    
    init(viewModel: ImageDownloadViewModel, imageURL: String) {
        self.viewModel = viewModel
        self.imageURL = imageURL
    }
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage(url: imageURL)
            }
        }
    }
}

struct ProfilePicWidget_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicWidget(viewModel:HomeDiContainer.shared.makeImageViewModel(), imageURL: "https://www.example.com/sampleImage.jpg")
    }
}

