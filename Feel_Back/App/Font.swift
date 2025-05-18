//
//  Font.swift
//  FeelBack
//
//  Created by kim yijun on 4/22/25.
//

import SwiftUI

extension Font {
    
        static let feelbackfont50: Font = .custom("Ownglyph_meetme-Rg", size: 50)
    
       static func feelbackfont(_ size: CGFloat) -> Font {
            return .custom("Ownglyph_meetme-Rg", size: size)
        }
        
}
