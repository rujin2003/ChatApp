//
//  Login.swift
//  ChatApp
//
//  Created by Apple on 03/06/24.
//

import SwiftUI

import SwiftUI

struct Login: View {
    @StateObject var LoginviewModel : LoginViewModel
    @StateObject var SignupModel : SignupViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage()
                
                VStack(spacing: 16) {
                    Text("Login with your username and password into the amazing app")
                        .frame(width: 320)
                        .offset(y: -220)
                        .foregroundColor(.gray)
                    
                    LoginFields()
                    
                    LoginBtn()
                }
        signupPage()
                
                NavigationLink(destination: ContentView(), isActive: $LoginviewModel.logedIn) { EmptyView() }

                
                
            }
            .navigationTitle("Login")
            .alert(isPresented: $LoginviewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(LoginviewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

extension Login {
    func BackgroundImage() -> some View {
        Image("monster")
    }
    
    func LoginFields() -> some View {
        VStack {
            TextField("Username", text: $LoginviewModel.username)
                .padding()
                .frame(width: 200, height: 40)
                .background(Color.white)
                .cornerRadius(10)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $LoginviewModel.password)
                .padding()
                .frame(width: 200, height: 40)
                .background(Color.white)
                .cornerRadius(10)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
    
    func LoginBtn() -> some View {
        Button(action: {
            LoginviewModel.loginUser()
        }) {
            HStack {
                Text("Login")
                Image(systemName: "arrow.right")
            }
            .frame(width: 90, height: 40)
            .background(Color(red: 240 / 255, green: 128 / 255, blue: 128 / 255))
            .cornerRadius(10)
            .foregroundColor(.white)
        }
        .offset(x: 0, y: 20)
    }
    
    func signupPage() -> some View {
        return
            NavigationLink(destination: Signup(SignupviewModel:SignupModel)) {
             
                    HStack{
                        Text("Create a Account")
                        Image(systemName: "arrow.right")
                    
                
                            }
            
            
        }.offset(x:100,y:300).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(LoginviewModel: AuthDIContainer.shared.makeLoginViewModel(),SignupModel: AuthDIContainer.shared.makeSignUpViewModel())
    }
}
