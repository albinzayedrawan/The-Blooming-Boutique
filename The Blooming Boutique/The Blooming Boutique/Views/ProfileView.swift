import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appData: ApplicationData
    @Binding var isLoggedOut: Bool
    @State private var navigateToSignIn = false // Add a state variable to control navigation

    var loggedInUserFirstName: String

    var body: some View {
        VStack {
            Text("Profile")
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)

            Image(systemName: "person")
                .font(.system(size: 200))
                .background(Color.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                .padding(.top)

            Text("\(loggedInUserFirstName)")
                .foregroundColor(Color.black)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.top)

            HStack {
                NavigationLink(
                    destination: EditAccountView(isLoggedOut: $isLoggedOut),
                    label: {
                        Text("Edit Account")
                            .frame(alignment: .leading)
                    }
                )
                .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)

                Text("or")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))

                Button(action: {
                    appData.cartItems.removeAll() // Clear the cart items
                    isLoggedOut = true // Set the logout state to true
                    navigateToSignIn = true // Set the navigation state to true
                }, label: {
                    Text("Log Out")
                        .frame(alignment: .leading)
                })
                .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            }
            .onAppear {
                isLoggedOut = false // Reset the logout state when the view appears
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .fullScreenCover(isPresented: $navigateToSignIn, content: {
            SignInView(isLoggedOut: $isLoggedOut)
        }) // Present the SignInView as a full screen cover
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isLoggedOut: .constant(false), loggedInUserFirstName: "Rawan A.")
    }
}
