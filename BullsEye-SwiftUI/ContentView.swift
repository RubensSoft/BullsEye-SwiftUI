import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var round = 1
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
            }) {
                Text("Hit me!!!")
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("See you soon")){
                        self.score += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            Spacer()
            
            HStack {
                Button(action: {}) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    private func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = abs(sliderValueRounded - target)
        var points = 0
        
        if difference == 0 {
            points = 200
        } else if difference == 1 {
            points = 150
        } else {
            points = maximumScore - difference
        }
        
        return points
    }
    
    private func scoringMessage() -> String {
        return "The slider's value is: \(sliderValueRounded).\n" +
            "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    private func alertTitle() -> String {
        let difference = abs(sliderValueRounded - target)
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
