import SwiftUI

struct InformationView: View {
    @State private var name = ""
    @State var countryId = ""
    @State private var city = ""
    @State private var number = ""
    @State private var address = ""
    @State private var cardMessage = ""
    @State private var showAlert = false
    @Binding var isLoggedOut: Bool // Add the binding property

    var loggedInUserFirstName: String
        
    var body: some View {
        VStack {
            Text("Information")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            
            contentView()
            
            HStack {
                backButton()
                
                Text("or")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                
                paymentButton()
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
    }
    
    func contentView() -> some View {
        VStack(alignment: .leading) {
            Group {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Name", text: $name)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .font(.system(size: 20))
                }
                
                HStack {
                    CountryPicker(countryId: $countryId)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        Text("City")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                        
                        TextField("Insert City", text: $city)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .font(.system(size: 20))
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Group {
                    Text("Phone Number")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Phone Number", text: $number)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .font(.system(size: 20))
                    
                    Text("Address")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Address", text: $address)
                        .font(.system(size: 20))
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    
                    Text("Card Message")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Message", text: $cardMessage)
                        .font(.system(size: 20))
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                }
            }
        }
    }
    
    func backButton() -> some View {
        Button {
            // Handle button action
        } label: {
            NavigationLink(destination: HomeView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)) {
                Text("Back to Home")
                    .frame(alignment:.leading)
            }
        }
        .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
        .font(.system(size: 20))
        .fontWeight(.bold)
        .padding(.top)
    }
    
    func paymentButton() -> some View {
        Button {
            // Handle button action
        } label: {
            NavigationLink(destination: chooseDestination()) {
                Text("Payment")
                    .frame(alignment:.leading)
            }
        }
        .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
        .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
        .font(.system(size: 20))
        .fontWeight(.bold)
        .padding(.top)
    }
    
    @ViewBuilder
    func chooseDestination() -> some View {
        if !name.isEmpty && !city.isEmpty && !number.isEmpty && !address.isEmpty && !cardMessage.isEmpty {
            PaymentView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName)
                .navigationBarBackButtonHidden(true)
        } else {
            InformationView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invalid inputs"),
                        message: Text("Please fill in all the fields."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .onAppear {
                    showAlert = true
                }
        }
    }
}

struct CountryPicker: View {
    @Binding var countryId: String
    @Environment(\.locale) var locale
    
    var body: some View {
        Picker("", selection: $countryId) {
            ForEach(Locale.isoRegionCodes, id: \.self) { iso in
                Text(locale.localizedString(forRegionCode: iso)!)
                    .tag(iso)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(isLoggedOut: .constant(false), loggedInUserFirstName: "Rawan A.")
    }
}
