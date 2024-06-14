//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
           AddFriend()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ContentView()
}
