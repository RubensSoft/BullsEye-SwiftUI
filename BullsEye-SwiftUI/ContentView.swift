import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .fontWeight(.semibold)
            Button(action: {
                print("Hit me again!")
            }) {
                Text("Hit me!!!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
