import SwiftUI

struct ProfilePicWidget: View {
    @ObservedObject var viewModel: ImageDownloadViewModel
    let imageURL: String?
    @State private var showPlaceholder = false

    init(viewModel: ImageDownloadViewModel, imageURL: String?) {
        self.viewModel = viewModel
        self.imageURL = imageURL
    }

    var body: some View {
        VStack {
            if let image = viewModel.image, !showPlaceholder {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
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
            }
        }
        .onAppear {
            if let imageURL = imageURL,
               !imageURL.trimmingCharacters(in: .whitespaces).isEmpty,
               let url = URL(string: imageURL), UIApplication.shared.canOpenURL(url) {
                Task {
                    await viewModel.fetchImage(url: imageURL)
                    if viewModel.image == nil {
                        showPlaceholder = true
                    }
                }
            } else {
                showPlaceholder = true
            }
        }
    }
}

struct ProfilePicWidget_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicWidget(viewModel: HomeDiContainer.shared.makeImageViewModel(), imageURL: "https://www.example.com/sampleImage.jpg")
    }
}

