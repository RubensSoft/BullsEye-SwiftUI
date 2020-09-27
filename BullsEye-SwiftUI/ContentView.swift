import SwiftUI

struct ContentView: View {
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
                    .fontWeight(.bold)
            }
            Spacer()
            
            HStack {
                Text("1")
                Slider(value: .constant(10))
                Text("100")
            }
            Spacer()
            
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
            Spacer()
            
            HStack {
                Button(action: {}) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                Spacer()
                Text("Round:")
                Text("999")
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
