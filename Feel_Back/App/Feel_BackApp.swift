//
//  Feel_BackApp.swift
//  Feel_Back
//
//  Created by kim yijun on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct Feel_BackApp: App {
   
    init() {
        
       if let backButtonImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysTemplate) {
           UINavigationBar.appearance().backIndicatorImage = backButtonImage
           UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
           UIBarButtonItem.appearance().setTitleTextAttributes(
               [NSAttributedString.Key.font: UIFont(name: "Ownglyph_meetme-Rg", size: 20)!],
               for: .normal
               
           )

        }
        
        UIView.appearance(whenContainedInInstancesOf: [UIWindow.self]).overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView{
                ContentView()
            }.tint(.bluecolor)
                        
        }
        .modelContainer(for: [OneEmotion.self, Comment.self])
    }
}
