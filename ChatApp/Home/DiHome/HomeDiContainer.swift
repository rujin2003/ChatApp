//
//  HomeDiContainer.swift
//  ChatApp
//
//  Created by Rujin on 15/06/24.
//

import Foundation

class HomeDiContainer {
    static let shared = HomeDiContainer()
    private init(){
        
    }
    lazy var imageDatas : ImageDownloadProtocol = {
        ImageDownload()
    }()
    
    func makeHomePageViewModel()-> HomePageViewModel{
        HomePageViewModel()
    }
    func makeImageViewModel()-> ImageDownloadViewModel{
        ImageDownloadViewModel(loader: imageDatas)
    }
    
}
