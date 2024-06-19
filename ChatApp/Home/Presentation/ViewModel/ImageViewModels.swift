//
//  ImageViewModels.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//



import SwiftUI

class ImageDownloadViewModel: ObservableObject {
    @Published var image: UIImage?
    let loader: ImageDownloadProtocol
    
    init(loader: ImageDownloadProtocol) {
      
        self.loader = loader
    }
    
    func fetchImage(url: String?) async {
        guard let url = url else{
            print("cannot fetch image")
            return 
        }
        if let image = await loader.getImage(urlstring: url) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            print("Error downloading image")
        }
    }
}
