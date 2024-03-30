import SwiftUI

struct CartCell: View {
    let flower: FlowerViewModel

    var body: some View {
        HStack(alignment: .center) {
            Image(flower.cover)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.all, 20)
            
            VStack(alignment: .leading) {
                Text(flower.item)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                HStack {
                    Text("Price per item: BHD" + String.init(format: "%0.2f", flower.price))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 46/255, green: 95/255, blue: 74/255))
                        .padding(.top, 8)
                }
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
        .cornerRadius(20)
        .padding(.all, 10)
    }
}

struct CartCell_Previews: PreviewProvider {
    static var previews: some View {
        CartCell(flower: FlowerViewModel(flower: Flower(cover: "Bouquet1", item: "Item: 001", price: 10.0)))
    }
}
