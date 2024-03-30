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
                FavoritesListView().tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            }
            .accentColor(.accentColor)
        }
        .background(ColoredView(color: Color(red: 230/255, green: 215/255, blue: 192/255)))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(loggedInUserFirstName: "Rawan A.", isLoggedOut: .constant(false)).environmentObject(ApplicationData())
    }
}
