import Foundation
import SwiftUI
import FirebaseAuth

class SignupViewModel: ObservableObject {
    @Published var textFieldState: String = "Username"
    @Published var textFieldStateValue: String = ""
    @Published var email: String = ""
    @Published var signupStateCounter: Int = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var signedUp: Bool = false
    
    @Published var image: UIImage?
    @Published var showImagePicker: Bool = false

    private let signupStateManager = ["Email", "Phoneno", "Password"]
    private var user = User(username: "DummyData", email: "dummy@gmail.com", phoneno: "dummy data")
    
    let networkSignup: SignupProtocol
    
    init(netsignup: SignupProtocol) {
        networkSignup = netsignup
    }
    
    func performPasswordAction(completion: @escaping (Bool) -> Void) {
        let password = textFieldStateValue
        SignupAuth.shared.signupUser(email: user.email, password: password) { result in
            switch result {
            case .success:
                print("Signup successful")
                completion(true)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                completion(false)
            }
        }
    }
    
    func advanceSignupState(completion: @escaping () -> Void) {
        switch textFieldState {
        case "Username":
            user.username = textFieldStateValue
        case "Email":
            user.email = textFieldStateValue
        case "Phoneno":
            user.phoneno = textFieldStateValue
        case "Password":
            performPasswordAction { success in
                if success {
                    guard let profileImageData = self.image?.jpegData(compressionQuality: 0.8) else {
                        self.alertMessage = "Profile picture not available"
                        self.showAlert = true
                        print("Profile picture not available")
                      
                        completion()
                        
                        return
                    }
                    self.networkSignup.uploadData(user: self.user.username, mail: self.user.email, no: self.user.phoneno, image: profileImageData)
                    self.signedUp = true
                    self.resetSignupProcess()
                
                } else {
                    print("Password action failed")
                    self.resetSignupProcess()
                    completion()
                }
            }
            return
        default:
            break
        }

        textFieldStateValue = ""  // Clear the text field value
        if signupStateCounter < signupStateManager.count {
            textFieldState = signupStateManager[signupStateCounter]
            signupStateCounter += 1
        }
        completion()
    }
    
    private func resetSignupProcess() {
        textFieldState = "Username"
        textFieldStateValue = ""
        signupStateCounter = 0
    }
}

