//
//  ChatUser.swift
//  ChatApp
//
//  Created by Rujin on 13/06/24.
//

import SwiftUI

struct ChatUser: View {
    var body: some View {
        VStack(spacing:0){
         
            Divider()
          
            HStack {
                Circle().frame(width: 50,height: 50).padding()
                VStack(alignment:.leading,spacing:5){
                    Text("Rujin Devkota").font(.system(size:20))
                    
                   
                    Text("hello my name is rujib").font(.system(size: 17,weight:.light)).foregroundColor(.gray)
                }
                Spacer()
                Text("3d").bold().padding()
                  }
                  .frame(width: 370, height: 75)
                  .background(Color.white)
              .cornerRadius(10) .padding()
           
        }
              /*shadow(color: Color.black.opacity(0.2), radius: 10, x:1, y: 2)*/
            
          }
}

#Preview {
    ChatUser()
}
