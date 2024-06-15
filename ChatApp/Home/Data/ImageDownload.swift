//
//  ImageDownload.swift
//  ChatApp
//
//  Created by Rujin on 14/06/24.
//

import Foundation
import SwiftUI
 class ImageDownload {
     
    let cache = NSCache<NSString, UIImage>()
    
   func getImage(urlstring: String)async -> UIImage?{
      
        
    let cashKey = NSString(string: urlstring)
       
    if let image = cache.object(forKey: cashKey){
            
            return image
        }
       
       guard let url = URL(string: urlstring) else {
           print("URL ERROR! I")
           return nil
       }
       
      
       
       do {
           let (data, _) = try await URLSession.shared.data(from: url)
         
           
           let image = UIImage(data: data)
           if let image = image{
               self.cache.setObject(image, forKey: cashKey)
               print("sucessfull")
              
           }
           
           return image
           
           
       } catch {
           print("Decoding Error: \(error)")
           return nil
       }

       
        
    }
}
