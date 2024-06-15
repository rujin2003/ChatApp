//
//  ImageViewModels.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//



import SwiftUI

class ImageDownloadViewModel: ObservableObject {
    @Published var image: UIImage?
    let loader: ImageDownload = ImageDownload()
    
    func fetchImage(url: String) async {
        if let image = await loader.getImage(urlstring: url) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            print("Error downloading image")
        }
    }
}
