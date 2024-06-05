import SwiftUI

struct Signup: View {
    @StateObject  var SignupviewModel : SignupViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage()
                SignUpField()
                MainBtn()
            }
            .navigationTitle("Signup")
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $SignupviewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(SignupviewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func BackgroundImage() -> some View {
        Image("monster2")
    }

    private func SignUpField() -> some View {
        VStack {
            TextField(SignupviewModel.textFieldState, text: $SignupviewModel.textFieldStateValue)
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
                SignupviewModel.advanceSignupState {
                    if SignupviewModel.signedUp {
                        dismiss()
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
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup(SignupviewModel: AuthDIContainer.shared.makeSignUpViewModel())
    }
}

