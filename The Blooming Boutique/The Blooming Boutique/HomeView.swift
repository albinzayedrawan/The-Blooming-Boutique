import SwiftUI

struct HomeView: View {
    var loggedInUserFirstName: String
    @Binding var isLoggedOut: Bool

    init(loggedInUserFirstName: String, isLoggedOut: Binding<Bool>) {
        self.loggedInUserFirstName = loggedInUserFirstName
        self._isLoggedOut = isLoggedOut

        UITabBar.appearance().barTintColor = UIColor(red: 245/255, green: 245/255, blue: 230/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 166/255, green: 124/255, blue: 167/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor(red: 46/255, green: 95/255, blue: 74/255, alpha: 1)
    }

    var body: some View {
        VStack {
            TabView {
                BestSellingView().tabItem {
                    Label("Best Sellers", systemImage: "dollarsign")
                }
                BouquetView().tabItem {
                    Label("Bouquets", systemImage: "heart")
                }
                VaseView().tabItem {
                    Label("Flowers in Vase", systemImage: "trophy")
                }
                SingleView().tabItem {
                    Label("Single Flowers", systemImage: "camera.macro")
                }
                ProfileView(isLoggedOut: $isLoggedOut, loggedInUserFirstName: loggedInUserFirstName).tabItem {
                    Label("Profile", systemImage: "person")
                }
                CartView(loggedInUserFirstName: loggedInUserFirstName, isLoggedOut: $isLoggedOut).tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            }
            .accentColor(.accentColor)
        }
        .background(ColoredView(color: Color(red: 230/255, green: 215/255, blue: 192/255)))
    }
}

struct BestSellingView: View {
    let columns: [GridItem] = [
        GridItem(.fixed(115)),
        GridItem(.fixed(115))
    ]
    
    @EnvironmentObject var appData: ApplicationData
 
    var body: some View {
        VStack {
            Text("Best Sellers")
                .foregroundColor(Color.black)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(appData.bestSellingData) { best in
                        VStack {
                            Image(best.cover)
                                .frame(width: 115, height: 115)
                            Text(best.item)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Text("BHD" + String(format: "%0.2f", best.price))
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Button(action: {
                                appData.cartItems.append(best)
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
                    }
                }
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
    }
}

struct BouquetView: View {
    let columns: [GridItem] = [
        GridItem(.fixed(115)),
        GridItem(.fixed(115))
    ]
    
    @EnvironmentObject var appData: ApplicationData
 
    var body: some View {
        VStack {
            Text("Flower Bouquets")
                .foregroundColor(Color.black)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(appData.bouquetData) { bouquet in
                        VStack {
                            Image(bouquet.cover)
                                .frame(width: 115, height: 115)
                            Text(bouquet.item)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Text("BHD" + String(format: "%0.2f", bouquet.price))
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Button(action: {
                                appData.cartItems.append(bouquet)
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
                    }
                }
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
    }
}

struct VaseView: View {
    let columns: [GridItem] = [
        GridItem(.fixed(115)),
        GridItem(.fixed(115))
    ]
    
    @EnvironmentObject var appData: ApplicationData
 
    var body: some View {
        VStack {
            Text("Flowers in Vase")
                .foregroundColor(Color.black)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(appData.vaseData) { vase in
                        VStack {
                            Image(vase.cover)
                                .frame(width: 115, height: 115)
                            Text(vase.item)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Text("BHD" + String(format: "%0.2f", vase.price))
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Button(action: {
                                appData.cartItems.append(vase)
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
                    }
                }
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
    }
}

struct SingleView: View {
    let columns: [GridItem] = [
        GridItem(.fixed(115)),
        GridItem(.fixed(115))
    ]
    
    @EnvironmentObject var appData: ApplicationData
 
    var body: some View {
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
                            Image(single.cover)
                                .frame(width: 115, height: 115)
                            Text(single.item)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Text("BHD" + String(format: "%0.2f", single.price))
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                            Button(action: {
                                appData.cartItems.append(single)
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
                    }
                }
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
        .padding(.top, 70)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(loggedInUserFirstName: "Rawan A.", isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
