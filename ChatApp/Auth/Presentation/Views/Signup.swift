import SwiftUI

struct Signup: View {
    @StateObject  var SignupviewModl : SignupViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage()
                ProfilePic().offset(x:0,y:-250)
                SignUpField()
                MainBtn()
            }
            .navigationTitle("Signup")
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $SignupviewModl.showAlert) {
                Alert(title: Text("Error"), message: Text(SignupviewModl.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func BackgroundImage() -> some View {
        Image("monster2")
    }

    private func SignUpField() -> some View {
        VStack {
            TextField(SignupviewModl.textFieldState, text: $SignupviewModl.textFieldStateValue)
                .padding()
                .frame(width: 200, height: 40)
                .background(Color.white)
                .cornerRadius(5)
                .offset(x: 0, y: -20)
        }
    }

    private func MainBtn() -> some View {
        Button(action: {
            withAnimation {
                SignupviewModl.advanceSignupState {
                    if SignupviewModl.signedUp {
                        DispatchQueue.main.async {
                            dismiss()
                                                }
                    }
                }
            }
        }) {
            Image(systemName: "arrow.forward.square.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(red: 235 / 255, green: 222 / 255, blue: 240 / 255))
        }
        .offset(x: 80, y: 30)
    }
    
    private func ProfilePic() -> some View {
        if SignupviewModl.image == nil {
            return AnyView(
                Button {
                    SignupviewModl.showImagePicker.toggle()
                } label: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
                .sheet(isPresented: $SignupviewModl.showImagePicker) {
                    ImagePicker(image: $SignupviewModl.image)
                }
            )
        } else {
            return AnyView(
                Button {
                    SignupviewModl.showImagePicker.toggle()
                } label: {
                    Image(uiImage: SignupviewModl.image!)
                        .resizable()
                        .cornerRadius(50)
                        .padding(.all, 4)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .clipShape(Circle())
                }
                .sheet(isPresented: $SignupviewModl.showImagePicker) {
                    ImagePicker(image: $SignupviewModl.image)
                }
                .padding(8)
            )
        }
    }

}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup(SignupviewModl: AuthDIContainer.shared.makeSignUpViewModel())
    }
}

