import SwiftUI

@main
struct The_Blooming_BoutiqueApp: App {
    @StateObject var appData = ApplicationData()
    
    var body: some Scene {
        WindowGroup {
            SignInView(isLoggedOut: .constant(false)).environmentObject(appData)
        }
    }
}
