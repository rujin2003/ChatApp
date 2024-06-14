//
//  HomePage.swift
//  ChatApp
//
//  Created by Rujin on 13/06/24.
//

import SwiftUI

struct HomePage: View {
    @StateObject var homeModel = HomePageViewModel()
    var body: some View {
        VStack{
            HStack{
                Text("Welcome \(homeModel.userData.username)").font(.system(size: 25)).padding().bold()
                Spacer()
                Circle().frame(width:50,height: 50).padding().overlay{
                    Image("")
                   
                    }
            }
        
            Spacer()
            
    VStack{
                ScrollView{
                    ForEach(0...10,id: \.self){ _ in
                        ChatUser()
                    }
                }
            }
        }.navigationBarBackButtonHidden(true).onAppear{
            Task{
               try await homeModel.getUserData()
            }
        }
    }
}

#Preview {
    HomePage()
}
