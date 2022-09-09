//
//  ContentView.swift
//  Bullseye
//
//  Created by Eric Holdener on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack {
            Spacer()
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
            }
            .padding()
            
            Spacer()
            
            // Slider Row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
                .padding()
            
            // Button Row
            Button("Hit Me!") {
                self.alertIsVisible = true
            }
            .alert(isPresented: $alertIsVisible) {
                () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("The slider's value is \(self.sliderValue)"), dismissButton: .default(Text("Awesome")))
            }
            
            Spacer()
            
            //Score Row
            HStack() {
                Button("Start Over") {
                    
                }
                Spacer()
                Text("Score: 999999")
                Spacer()
                Text("Round: 999")
                Spacer()
                Button("Info") {
                    
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
