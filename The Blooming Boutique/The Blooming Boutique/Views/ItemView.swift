import SwiftUI

struct ItemView: View {
    @EnvironmentObject var appData: ApplicationData
    @State private var showAlert = false
    var flower: FlowerViewModel

    var body: some View {
        VStack {
            Image(flower.cover)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                .padding()
            
            Text("\(flower.item)")
                .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .multilineTextAlignment(.center)
                .padding()
            
            Text("BHD " + String(format: "%0.2f", flower.price))
                .foregroundColor(.gray)
                .font(.system(size: 25))
                .multilineTextAlignment(.leading)
                .padding()
            
            Button(action: {
                appData.toggleFavorite(for: flower)
                showAlert = true // Set showAlert to true when adding to favorites
            }) {
                Text("Add to Favorites")
                    .frame(alignment: .leading)
            }
            .buttonStyle(PlainButtonStyle())
            .tint(Color(red: 245/255, green: 245/255, blue: 230/255))
            .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))
            .font(.system(size: 40))
            .fontWeight(.bold)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Added to Favorites"), message: nil, dismissButton: .default(Text("OK")))
            }
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
        .padding()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(flower: FlowerViewModel(flower: Flower(cover: "Bouquet1", item: "Item: 001", price: 10.0)))
            .environmentObject(ApplicationData())
    }
}
