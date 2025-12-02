import SwiftUI

struct PaymentView: View {
    @State private var name = ""
    @State private var number = ""
    @State private var date = Date()
    @State private var cvv = ""
    @State private var showAlert = false
    @Binding var isLoggedOut: Bool

    var loggedInUserFirstName: String
        
    var body: some View {
        VStack {
            Image("card")
                .frame(width: 25, height: 25)
                .padding(.bottom, 100)
            
            Group {
                VStack(alignment: .leading) {
                    Text("Card Owner")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Name", text: $name)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .font(.system(size: 20))
                }
            }
            
            Group {
                VStack(alignment: .leading) {
                    Text("Card Number")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    TextField("Insert Card Number", text: $number)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .font(.system(size: 20))
                }
                
                HStack{
                    DatePicker("Exp:", selection: $date, displayedComponents: [.date]).font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                    
                    VStack (alignment: .leading){
                        Text("CVV")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                        
                        SecureField("Insert CVV", text: $cvv)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .font(.system(size: 20))
                    }
                }
                
            }
            
            HStack{
                Button {
                }
                label: {
                    NavigationLink(destination: HomeView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut).toolbar(.hidden, for: .tabBar).navigationBarBackButtonHidden(true)) {
                                Text("Back to Home")
                                .frame(alignment:.leading)
                            }}.tint(Color(red: 245/255, green: 245/255, blue: 230/255))
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
                }
                label: {
                        NavigationLink(destination: chooseDestination()) {
                                Text("Confirm")
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
    @ViewBuilder
    func chooseDestination() -> some View {
        if !name.isEmpty && !number.isEmpty && !cvv.isEmpty {
            ConfirmationView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut)
                .navigationBarBackButtonHidden(true)
        } else {
            PaymentView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName)
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

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(isLoggedOut: .constant(false), loggedInUserFirstName: "Rawan A.")
    }
}
