import SwiftUI

struct ConfirmationView: View {
    var loggedInUserFirstName: String
    @Binding var isLoggedOut: Bool

    var body: some View {
        VStack {
            Image("Confirmed")
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                .imageScale(.large)
                .padding()
            Text("Order Received!")
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .multilineTextAlignment(.center)
                .padding()
            .padding()
            Text("Your order has been confirmed, we will send you confirmation email shortly.")
                .foregroundColor(.gray)
                .font(.system(size: 25))
                .multilineTextAlignment(.leading)
                .padding()
            .padding()
            Button {
            }
            label: {
                NavigationLink(destination: HomeView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)) {
                            Text("Done")
                            .frame(alignment:.leading)
                        }}.tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                .font(.system(size: 50))
                .fontWeight(.bold)
            
        }.background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(loggedInUserFirstName: "Rawan A.", isLoggedOut: .constant(false))
    }
}
