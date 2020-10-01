import SwiftUI

struct ContentView: View {
    @State var target = Int.random(in: 1...100)
    @State var sliderValue = 50.0
    @State var isAlertPresented = false
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
                    .fontWeight(.bold)
            }
            Spacer()
            
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
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
                      message: Text(scoringMessage()),
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
            .padding(.bottom, 20)
        }
    }
    
    private func pointsForCurrentRound() -> Int {
        let difference: Int
        if sliderValueRounded > target {
            difference = sliderValueRounded - target
        } else if target > sliderValueRounded {
            difference = target - sliderValueRounded
        } else {
            difference = 0
        }
        return 100 - difference
    }
    
    private func scoringMessage() -> String {
        return "The slider's value is: \(sliderValueRounded).\n" +
            "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
