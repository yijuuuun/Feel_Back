//
//  LaunchScreen.swift
//  FeelBack
//
//  Created by kim yijun on 4/14/25.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundLight
                .ignoresSafeArea()
            
            VStack {
                
                HStack{
                    Image("thankcloud")
                    Image("angrycloud")
                    Image("comfortcloud")
                    Image("lovecloud")
                    Image("sadcloud")
                }.padding()
                
                Text("Feel Back")
                    .font(.feelbackfont(50))
                    .foregroundColor(.bluecolor)
                
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
