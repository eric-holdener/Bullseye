//
//  AboutView.swift
//  Bullseye
//
//  Created by Eric Holdener on 9/10/22.
//

import SwiftUI

struct AboutView: View {
    let burntOrange = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 30))
                .padding(.vertical, 20.0)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 16))
                .padding(.horizontal, 60.0)
                .padding(.bottom, 20.0)
        }
    }
    var body: some View {
        ZStack {
            burntOrange.ignoresSafeArea()
            VStack() {
                Text("🎯 Bullseye 🎯")
                    .modifier(HeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(TextStyle())
                Text("Enjoy!")
                    .modifier(TextStyle())
            }
            .multilineTextAlignment(.center)
            .navigationTitle("About Bullseye")
        }

    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .previewDevice("iPhone 12")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
