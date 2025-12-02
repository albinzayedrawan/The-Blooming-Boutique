import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var loggedInUserFirstName: String = ""
    @State private var showAlert = false
    @Binding var isLoggedOut: Bool

    @EnvironmentObject var appData: ApplicationData
        
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .frame(width: 25, height: 25)
                    .padding(.bottom, 100)
                
                VStack (alignment: .leading) {
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
                }

                Button {
                    updateName()
                }
                label: {
                        NavigationLink(destination: chooseDestination().navigationBarBackButtonHidden(true)) {
                                Text("Sign In")
                                    .frame(maxWidth: .infinity)
                            }}.tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                    .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top)
                
                Button {
                }
                label: {
                        NavigationLink(destination: ForgotYourPasswordView(isLoggedOut: $isLoggedOut)) {
                                Text("Forgot Your Password?")
                                    .frame(maxWidth: .infinity)
                            }}.tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                    .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top)
                
                HStack{
                    Text("New Account?")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    Button {
                    }
                    label: {
                        NavigationLink(destination: SignUpView(isLoggedOut: $isLoggedOut)) {
                                    Text("Sign Up")
                                    .frame(alignment:.leading)
                                }}.tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top)
                }
            }.background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
                   .padding()
                   .padding(.top, 70)
        }

    }
    
    func updateName() {
        if let user = appData.userData.first(where: { user in
            user.emailAddress == email && user.password == password
        }) {
            loggedInUserFirstName = "\(user.firstName) \(user.lastName)"
        } else {
            loggedInUserFirstName = "" // Reset the value if no user is found
        }
    }

    @ViewBuilder
    func chooseDestination() -> some View {
        if let user = appData.userData.first(where: { user in
            user.emailAddress == email && user.password == password
        }) {
            HomeView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut)
                .environmentObject(appData)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    loggedInUserFirstName = "\(user.firstName) \(user.lastName)"
            }
        } else {
            SignInView(isLoggedOut: $isLoggedOut)
                .navigationBarBackButtonHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invalid credentials"),
                        message: Text("The email address or password is incorrect. Please try again."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .onAppear {
                    showAlert = true
                }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
