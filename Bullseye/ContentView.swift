//
//  ContentView.swift
//  Bullseye
//
//  Created by Eric Holdener on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.semibold)
                .foregroundColor(Color.green)
                .padding()
            Button("Hit Me!") {
                self.alertIsVisible = true
            }
            .alert(isPresented: $alertIsVisible) {
                () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("This is my first pop-up!"), dismissButton: .default(Text("Awesome")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
