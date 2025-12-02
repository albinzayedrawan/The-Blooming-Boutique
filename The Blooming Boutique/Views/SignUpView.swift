import SwiftUI

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var loggedInUserFirstName: String = ""
    @State private var showAlert = false
    @State private var signUpSuccess = false
    @Binding var isLoggedOut: Bool // Added the binding property
    
    @EnvironmentObject var appData: ApplicationData
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            
            contentView()
            
            Button(action: signUp) {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
            .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.top)
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid inputs"),
                message: Text("Please fill in all the fields and make sure the passwords match."),
                dismissButton: .default(Text("OK"))
            )
        }
        .fullScreenCover(isPresented: $signUpSuccess) {
            HomeView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut)
                .environmentObject(appData)
        }
    }
    
    func contentView() -> some View {
        VStack(alignment: .leading) {
            Text("First Name")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
            
            TextField("Insert First Name", text: $firstName)
                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                .font(.system(size: 20))
            
            Text("Last Name")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
            
            TextField("Insert Last Name", text: $lastName)
                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                .font(.system(size: 20))
            
            Group {
                Text("Email")
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
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                SecureField("Insert Password", text: $password)
                    .font(.system(size: 20))
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                
                Text("Confirm Password")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                SecureField("Insert Password", text: $confirmPassword)
                    .font(.system(size: 20))
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
            }
        }
    }
    
    func signUp() {
        if !email.isEmpty && password == confirmPassword && !firstName.isEmpty && !lastName.isEmpty {
            let newUser = User(emailAddress: email, password: password, firstName: firstName, lastName: lastName)
            appData.userData.append(newUser)
            
            // Set the state variables after successful sign-up
            loggedInUserFirstName = "\(firstName) \(lastName)"
            signUpSuccess = true
        } else {
            showAlert = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
