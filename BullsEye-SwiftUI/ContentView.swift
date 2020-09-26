import SwiftUI

struct ContentView: View {
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .fontWeight(.semibold)
            Button(action: {
                self.isAlertPresented = true
                print("Buton pressed")
            }) {
                Text("Hit me!!!")
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Hi there!"),
                      message: Text("Hit me again"),
                      dismissButton: .default(Text("See you soon")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
