import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var round = 1
    @State var target = 0
    @State var sliderValue = 0.0
    @State var isAlertPresented = false
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    var sliderTargerDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            Spacer()
            
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
                    .modifier(LabelStyle())
            }
            .padding(.horizontal, 40)
            Spacer()
            
            Button(action: {
                self.isAlertPresented = true
            }) {
                Text("Hit me!!!")
                    .font(.custom("Arial Rounded MT Bold", size: 18))
                    .foregroundColor(.black)
            }
            .background(
                Image("Button")
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
            )
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("See you soon")){
                        self.startNewRound()
                    })
            }
            Spacer()
            
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start over")
                        .font(.custom("Arial Rounded MT Bold", size: 18))
                        .foregroundColor(.black)
                }
                .background(
                    Image("Button")
                        .shadow(color: .black, radius: 5, x: 2, y: 2)
                )
                Spacer()
                Text("Score:")
                    .modifier(LabelStyle())
                Text("\(score)")
                    .modifier(ValueStyle())
                Spacer()
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(round)")
                    .modifier(ValueStyle())
                Spacer()
                Button(action: {}) {
                    Text("Info")
                        .font(.custom("Arial Rounded MT Bold", size: 18))
                        .foregroundColor(.black)
                }
                .background(Image("Button")
                .shadow(color: .black, radius: 5, x: 2, y: 2)
                )
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .onAppear() {
            self.startNewGame()
        }
        .background(Image("Background"))
    }
    
    private func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    private func startNewRound() {
        score += pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    private func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
    
    private func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        var points = 0
        if sliderTargerDifference == 0 {
            points = 200
        } else if sliderTargerDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargerDifference
        }
        return points
    }
    
    private func scoringMessage() -> String {
        return "The slider's value is: \(sliderValueRounded).\n" +
            "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    private func alertTitle() -> String {
        let title: String
        if sliderTargerDifference == 0 {
            title = "Perfect!"
        } else if sliderTargerDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargerDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.white)
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(.yellow)
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
