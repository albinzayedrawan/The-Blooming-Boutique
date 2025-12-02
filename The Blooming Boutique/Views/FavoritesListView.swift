import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var appData: ApplicationData
    @State private var editMode: EditMode = .inactive

    var body: some View {
        NavigationView {
            VStack {
                Text("Favorites")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color(red: 166/255, green: 124/255, blue: 167/255))

                List {
                    ForEach(appData.favoriteItems) { favorite in
                        FavItemCell(flower: favorite)
                            .contextMenu {
                                Button(action: {
                                    appData.toggleFavorite(for: favorite)
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                    .onDelete(perform: { indexSet in
                        // Use sorted indices to avoid index out of range error
                        let sortedIndices = indexSet.sorted(by: >)
                        for index in sortedIndices {
                            // Check if the index is within the bounds of the favoriteItems array
                            if index < appData.favoriteItems.count {
                                appData.removeFavorite(appData.favoriteItems[index])
                            }
                        }
                    })

                }
            }
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $editMode)
        }
        .background(ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255)))
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
            .environmentObject(ApplicationData())
    }
}
