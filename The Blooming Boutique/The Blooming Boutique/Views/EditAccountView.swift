import SwiftUI

struct EditAccountView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var successMessage = ""
    @State private var navigateToSignIn = false

    @EnvironmentObject var appData: ApplicationData
    @Binding var isLoggedOut: Bool

    var body: some View {
        VStack {
            Text("Edit Account")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))

            VStack(alignment: .leading) {
                Text("First Name")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))

                TextField("Insert First Name", text: $firstName)
                    .keyboardType(.emailAddress)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .font(.system(size: 20))

                Text("Last Name")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))

                TextField("Insert Last Name", text: $lastName)
                    .keyboardType(.emailAddress)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .font(.system(size: 20))

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
                editAccount(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
                isLoggedOut = true // Set the logout state to true when done editing account
                appData.cartItems.removeAll() // Clear the cart items
            }, label: {
                Text("Done")
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
                title: Text("Edit Account"),
                message: Text(successMessage),
                dismissButton: .default(Text("OK")) {
                    if successMessage == "Your details have been successfully changed, please log in again to apply the changes." {
                        navigateToSignIn = true
                    }
                }
            )
        })
    }

    func editAccount(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) {
        if !email.isEmpty && password == confirmPassword && !firstName.isEmpty && !lastName.isEmpty {
            // Find the user in the userData array based on the email address
            if let index = appData.userData.firstIndex(where: { $0.emailAddress == email }) {
                // Update the user's information
                appData.userData[index].password = password
                appData.userData[index].firstName = firstName
                appData.userData[index].lastName = lastName
                successMessage = "Your details have been successfully changed, please log in again to apply the changes."
                showAlert = true
            } else {
                successMessage = "Please fill all inputs correctly."
                showAlert = true
            }
        } else {
            successMessage = "Please fill all inputs correctly."
            showAlert = true
        }
    }
}


struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView( isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
