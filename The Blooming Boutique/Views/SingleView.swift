import SwiftUI

struct SingleView: View {
    let columns: [GridItem] = [
        GridItem(.fixed(115)),
        GridItem(.fixed(115))
    ]
    
    @EnvironmentObject var appData: ApplicationData
    @State private var selectedItem: FlowerViewModel?
    @State private var showingAlert = false // State variable to control alert presentation
 
    var body: some View {
        NavigationView {
            VStack {
                Text("Single Flowers")
                    .foregroundColor(Color.black)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(appData.singleData) { single in
                            VStack {
                                Button(action: {
                                    selectedItem = single
                                }) {
                                    Image(single.cover)
                                        .frame(width: 115, height: 115)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Text(single.item)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                                Text("BHD" + String(format: "%0.2f", single.price))
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                                Button(action: {
                                    appData.cartItems.append(single)
                                    showingAlert = true // Set showingAlert to true when the item is added to the cart
                                }) {
                                    Text("Add to cart")
                                        .frame(alignment: .leading)
                                }
                                .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
                                .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(.top)
                            }
                            .background(Color.clear)
                        }
                    }
                }
            }
            .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
            .padding()
            .padding(.top, 70)
            .sheet(item: $selectedItem) { item in
                ItemView(flower: item) 
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Item Added to Cart"), message: Text("The item has been added to your cart."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SingleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleView()
    }
}
