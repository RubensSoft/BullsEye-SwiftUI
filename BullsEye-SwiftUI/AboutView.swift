import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("🎯 BullsEye 🎯")
                .modifier(AboutHeadingStyle())
            Text("This is Bullseye, the game where you can win points and earn fame by draggin a slider.")
                .modifier(AboutBodyStyle())
            Text("Your goal is to place the slider as close as you possible to the target value. Te closer you are, the more points you score.")
                .modifier(AboutBodyStyle())
            Text("Enjoy!")
                .modifier(AboutBodyStyle())
        }
    }
}

struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(.black)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
