import Foundation

struct FlowerViewModel: Identifiable, Hashable {
    let id = UUID()

    var flower: Flower

    var cover: String {
        return flower.cover
    }
    
    var item: String {
        return flower.item
    }
    
    var price: Double {
        return flower.price
    }
    
    var isFavorite: Bool = false
}
