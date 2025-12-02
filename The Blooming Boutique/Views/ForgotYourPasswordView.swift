import SwiftUI

struct ForgotYourPasswordView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var successMessage = ""
    @State private var navigateToSignIn = false
    @Binding var isLoggedOut: Bool
    
    @EnvironmentObject var appData: ApplicationData
    
    var body: some View {
        VStack {
            Text("Forgot Your Password?")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            
            VStack(alignment: .leading) {
                Text("Email Address")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                TextField("Insert Email", text: $email)
                    .keyboardType(.emailAddress)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .font(.system(size: 20))
                
                Text("Password")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                SecureField("Insert Password", text: $password)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .font(.system(size: 20))
                
                Text("Confirm Password")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .font(.system(size: 20))
            }
            
            Button(action: {
                forgotPassword(email: email, password: password, confirmPassword: confirmPassword)
            }, label: {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
            })
            .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
            .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.top)
            
            NavigationLink(
                destination: SignInView(isLoggedOut: $isLoggedOut).navigationBarBackButtonHidden(true),
                isActive: $navigateToSignIn,
                label: {}
            )
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Password Reset"),
                message: Text(successMessage),
                dismissButton: .default(Text("OK")) {
                    if successMessage == "Your password has been successfully changed." {
                        navigateToSignIn = true
                    }
                }
            )
        })
    }
    
    func forgotPassword(email: String, password: String, confirmPassword: String) {
        if !email.isEmpty && password == confirmPassword {
            // Find the user in the userData array based on the email address
            if let index = appData.userData.firstIndex(where: { $0.emailAddress == email }) {
                // Update the user's information
                appData.userData[index].password = password
                successMessage = "Your password has been successfully changed."
                showAlert = true
            } else {
                successMessage = "Invalid email. Please enter a valid email address."
                showAlert = true
            }
        } else {
            successMessage = "Passwords do not match. Please make sure the passwords match."
            showAlert = true
        }
    }
}

struct ForgotYourPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotYourPasswordView(isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
