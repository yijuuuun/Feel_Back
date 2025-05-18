//
//  ContentView.swift
//  Feel_Back
//
//  Created by kim yijun on 5/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isLaunch: Bool = true
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            if isLaunch {
                LaunchScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.linear) {
                                self.isLaunch = false
                            }
                        }
                    }
            } else {
                MainView()
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: OneEmotion.self, Comment.self)
    ContentView()
        .modelContainer(container)
}
