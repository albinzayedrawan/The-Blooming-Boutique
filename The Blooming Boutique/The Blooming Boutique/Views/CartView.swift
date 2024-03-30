import SwiftUI

struct CartView: View {
    @EnvironmentObject var appData: ApplicationData
    var loggedInUserFirstName: String
    @Binding var isLoggedOut: Bool

    var subtotal: Double {
        appData.cartItems.reduce(0.0) { $0 + $1.price }
    }

    var body: some View {
        VStack {
            Text("Cart")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))

            ScrollView {
                LazyVStack {
                    ForEach(appData.cartItems) { item in
                        CartCell(flower: item)
                    }
                }
            }

            HStack {
                Button {
                    // View Information action
                } label: {
                    NavigationLink(destination: InformationView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName)) {
                        Text("View Information")
                            .frame(alignment: .leading)
                    }
                }
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

                Button {
                    // Credit Card action
                } label: {
                    NavigationLink(destination: PaymentView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName).navigationBarBackButtonHidden(true)) {
                        Text("Credit Card")
                            .frame(alignment: .leading)
                    }
                }
                .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            }

            Text("Order Details")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))

            VStack {
                HStack {
                    Text("Subtotal:")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    Spacer()
                    Text("BHD" + String(format: "%.2f", subtotal))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                }

                HStack {
                    Text("Delivery fee:")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    Spacer()
                    Text("BHD" + String(format: "%.2f", 1.0))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                }

                HStack {
                    Text("Total:")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    Spacer()
                    Text("BHD" + String(format: "%.2f", subtotal + 1))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                }
            }

            Button {
                // Continue action
            } label: {
                NavigationLink(destination: InformationView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName)) {
                    Text("Continue")
                        .frame(alignment: .leading)
                }
            }
            .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.top)
            .disabled(subtotal == 0) // Disable the button if the subtotal is equal to 0
            .foregroundColor(subtotal == 0 ? Color.gray : Color(red: 166/255, green: 124/255, blue: 167/255))
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .onAppear(perform: clearCartItems) // Call the function when the view appears
    }

    private func clearCartItems() {
        if isLoggedOut {
            appData.cartItems.removeAll() // Clear the cart items
        }
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(loggedInUserFirstName: "Rawan A.", isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
