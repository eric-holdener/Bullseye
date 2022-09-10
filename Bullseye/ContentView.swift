//
//  ContentView.swift
//  Bullseye
//
//  Created by Eric Holdener on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var infoIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
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
        VStack {
            Spacer()
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
            }
            .padding()
            
            Spacer()
            
            // Slider Row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
                .padding()
            
            // Button Row
            Button("Hit Me!") {
                self.alertIsVisible = true
            }
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
                Button("Start Over") {
                    newGame()
                }
                Spacer()
                Text("Score: \(score)")
                Spacer()
                Text("Round: \(round)")
                Spacer()
                Button("Info") {
                    self.infoIsVisible = true
                }
                .alert(isPresented: $infoIsVisible) {
                    () -> Alert in
                    return Alert(title: Text("Bullseye"), message: Text("Copyright by Eric Holdener, 2022"), dismissButton: .default(Text("Dismiss")))
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
