import Foundation

struct User: Identifiable, Equatable {
    let id = UUID()
    var emailAddress: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var favoriteItems: [FlowerViewModel] = []
}
