import Foundation

class ApplicationData: ObservableObject {
    @Published var userData: [User]
    @Published var bestSellingData: [FlowerViewModel]
    @Published var vaseData: [FlowerViewModel]
    @Published var bouquetData: [FlowerViewModel]
    @Published var singleData: [FlowerViewModel]
    @Published var cartItems: [FlowerViewModel] = []
    @Published var favoriteItems: [FlowerViewModel] = []
    @Published var subtotal: Double = 0.0
    @Published var loggedInUserFirstName: String = ""

    init() {
        userData = [
            User(emailAddress: "rawanalbinzayed@outlook.com", password: "12345", firstName: "Rawan", lastName: "Albinzayed"),
            User(emailAddress: "User1234@gmail.com", password: "67890", firstName: "John", lastName: "Appleseed")
        ]

        bestSellingData = [
            FlowerViewModel(flower: Flower(cover: "Bouquet1", item: "Item: 001", price: 10.0)),
            FlowerViewModel(flower: Flower(cover: "Vase1", item: "Item: 007", price: 10.0)),
            FlowerViewModel(flower: Flower(cover: "Single1", item: "Item: 013", price: 1.0)),
            FlowerViewModel(flower: Flower(cover: "Single6", item: "Item: 018", price: 1.0)),
            FlowerViewModel(flower: Flower(cover: "Vase6", item: "Item: 012", price: 12.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet6", item: "Item: 006", price: 9.0)),
        ]
        
        bouquetData = [
            FlowerViewModel(flower: Flower(cover: "Bouquet1", item: "Item: 001", price: 10.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet2", item: "Item: 002", price: 15.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet3", item: "Item: 003", price: 12.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet4", item: "Item: 004", price: 8.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet5", item: "Item: 005", price: 7.0)),
            FlowerViewModel(flower: Flower(cover: "Bouquet6", item: "Item: 006", price: 9.0)),
        ]
        
        vaseData = [
            FlowerViewModel(flower: Flower(cover: "Vase1", item: "Item: 007", price: 10.0)),
            FlowerViewModel(flower: Flower(cover: "Vase2", item: "Item: 008", price: 15.0)),
            FlowerViewModel(flower: Flower(cover: "Vase3", item: "Item: 009", price: 9.0)),
            FlowerViewModel(flower: Flower(cover: "Vase4", item: "Item: 010", price: 8.0)),
            FlowerViewModel(flower: Flower(cover: "Vase5", item: "Item: 011", price: 11.0)),
            FlowerViewModel(flower: Flower(cover: "Vase6", item: "Item: 012", price: 12.0)),
        ]
        
        singleData = [
            FlowerViewModel(flower: Flower(cover: "Single1", item: "Item: 013", price: 1.0)),
            FlowerViewModel(flower: Flower(cover: "Single2", item: "Item: 014", price: 1.0)),
            FlowerViewModel(flower: Flower(cover: "Single3", item: "Item: 015", price: 2.0)),
            FlowerViewModel(flower: Flower(cover: "Single4", item: "Item: 016", price: 5.0)),
            FlowerViewModel(flower: Flower(cover: "Single5", item: "Item: 017", price: 3.0)),
            FlowerViewModel(flower: Flower(cover: "Single6", item: "Item: 018", price: 1.0)),
        ]
    }
    
    func toggleFavorite(for flower: FlowerViewModel) {
        if let index = favoriteItems.firstIndex(where: { $0.id == flower.id }) {
            favoriteItems.remove(at: index)
            if let flowerIndex = bestSellingData.firstIndex(where: { $0.id == flower.id }) {
                bestSellingData[flowerIndex].flower.isFavorite = false
            }
            if let flowerIndex = vaseData.firstIndex(where: { $0.id == flower.id }) {
                vaseData[flowerIndex].flower.isFavorite = false
            }
            if let flowerIndex = bouquetData.firstIndex(where: { $0.id == flower.id }) {
                bouquetData[flowerIndex].flower.isFavorite = false
            }
            if let flowerIndex = singleData.firstIndex(where: { $0.id == flower.id }) {
                singleData[flowerIndex].flower.isFavorite = false
            }
        } else {
            favoriteItems.append(flower)
            if let flowerIndex = bestSellingData.firstIndex(where: { $0.id == flower.id }) {
                bestSellingData[flowerIndex].flower.isFavorite = true
            }
            if let flowerIndex = vaseData.firstIndex(where: { $0.id == flower.id }) {
                vaseData[flowerIndex].flower.isFavorite = true
            }
            if let flowerIndex = bouquetData.firstIndex(where: { $0.id == flower.id }) {
                bouquetData[flowerIndex].flower.isFavorite = true
            }
            if let flowerIndex = singleData.firstIndex(where: { $0.id == flower.id }) {
                singleData[flowerIndex].flower.isFavorite = true
            }
        }
    }

    func removeFavorite(_ flower: FlowerViewModel) {
        if let index = favoriteItems.firstIndex(where: { $0.id == flower.id }) {
            favoriteItems.remove(at: index)
        }
    }
}
