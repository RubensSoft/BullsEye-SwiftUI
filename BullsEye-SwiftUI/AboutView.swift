import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("🎯 BullsEye 🎯")
            Text("This is Bullseye, the game where you can win points and earn fame by draggin a slider.")
            Text("Your goal is to place the slider as close as you possible to the target value. Te closer you are, the more points you score.")
            Text("Enjoy!")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
