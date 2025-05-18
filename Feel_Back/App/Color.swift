//
//  Color.swift
//  FeelBack
//
//  Created by kim yijun on 4/14/25.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    
    static let primaryText = Color(hex: "A3B5CC")
    static let backgroundLight = Color(hex: "F5F9FE")
    static let bluecolor = Color(hex: "73BBDD")
    static let superblue = Color(hex: "3973DB")

    static let lightblue = Color(hex: "F2F6FF")

}
