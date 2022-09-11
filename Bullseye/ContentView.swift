//
//  ContentView.swift
//  Bullseye
//
//  Created by Eric Holdener on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(.custom("Arial Rounded MT Bold", size: 18))
                .modifier(DropShadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .modifier(DropShadow())
        }
    }
    
    struct DropShadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - abs(target - sliderValueRounded())
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func getRandomTarget() -> Int {
        Int.random(in: 1...100)
    }
    
    func getAlertTitle() -> Text {
        let points = pointsForCurrentRound()
        if (points == 100) {
            return Text("Perfect!")
        } else if (points > 85) {
            return Text("Almost!")
        } else {
            return Text("Not quite. Try again!")
        }
    }
    
    func getScore() -> Int {
        let roundScore = pointsForCurrentRound()
        if (roundScore == 100) {
            return roundScore + 100
        } else if (roundScore == 99) {
            return roundScore + 50
        } else {
            return roundScore
        }
    }
    
    func newGame() {
        self.score = 0
        self.round = 1
        self.sliderValue = 50.0
        self.target = getRandomTarget()
    }
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                // Target Row
                HStack {
                    Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                .padding()
                
                Spacer()
                
                // Slider Row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                    Text("100").modifier(LabelStyle())
                }
                .padding()
                
                // Button Row
                Button("Hit Me!") {
                    self.alertIsVisible = true
                }
                .modifier(ButtonLargeTextStyle())
                .background(Image("Button"))
                .modifier(DropShadow())
                .alert(isPresented: $alertIsVisible) {
                    () -> Alert in
                    return Alert(title: getAlertTitle(), message: Text("The slider's value is \(Int(sliderValueRounded()))\n" + "You scored \(getScore()) points this round."), dismissButton: .default(Text("Awesome"), action: {
                        self.score += getScore()
                        self.round += 1
                        self.target = getRandomTarget()
                    }))
                }
                
                Spacer()
                
                //Score Row
                HStack() {
                    Button {
                        newGame()
                    } label: {
                        HStack {
                            Image("StartOverIcon")
                            Text("Start Over")
                        }
                    }
                    .background(Image("Button"))
                    .modifier(DropShadow())
                    .modifier(ButtonSmallTextStyle())
                    Spacer()
                    Text("Score:").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                    Spacer()
                    Text("Round:").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info")
                        }
                    }
                    .modifier(ButtonSmallTextStyle())
                    .background(Image("Button"))
                    .modifier(DropShadow())
                }
                .padding()
            }
            .background(Image("Background"), alignment: .center)
            .accentColor(midnightBlue)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
