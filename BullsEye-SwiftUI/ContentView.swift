import SwiftUI

struct ContentView: View {
    let midnightBlueColor = Color(red: 0, green: 0.2, blue: 0.4)
    
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
                    .accentColor(.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            .padding(.horizontal, 40)
            Spacer()
            
            Button(action: {
                self.isAlertPresented = true
            }) {
                Text("Hit me!!!")
                    .modifier(ButtonLargeTextStyle())
            }
            .background(Image("Button").modifier(ShadowStyle()))
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
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button").modifier(ShadowStyle()))
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
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button").modifier(ShadowStyle()))
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            .accentColor(midnightBlueColor)
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
            .modifier(ShadowStyle())
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(.yellow)
            .modifier(ShadowStyle())
    }
}

struct ShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 14))
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
