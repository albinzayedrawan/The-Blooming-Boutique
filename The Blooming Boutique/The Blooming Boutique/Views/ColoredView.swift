import SwiftUI

struct ColoredView: UIViewRepresentable {
    var color: Color
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(color)
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .init(SwiftUI.Color(red: 245/255, green: 245/255, blue: 230/255))
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ColoredView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredView(color: Color(red: 245/255, green: 245/255, blue: 230/255))
    }
}
