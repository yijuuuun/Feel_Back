//
//  Emotion.swift
//  Feel_Back
//
//  Created by kim yijun on 5/12/25.
//

import Foundation

enum Emotion: String, CaseIterable, Codable {
    case thank
    case sad
    case angry
    case comfort
    case love
    
    var title: String {
        switch self {
        case .thank:
            return "땡큐구름"
        case .sad:
            return "먹구름"
        case .angry:
            return "화난구름"
        case .comfort:
            return "편안구름"
        case .love:
            return "따뜻구름"
        }
    }
    
    var imageName: String {
        switch self {
        case .thank:
            return "thankcircle"
        case .sad:
            return "sadcircle"
        case .angry:
            return "angrycircle"
        case .comfort:
            return "comfortcircle"
        case .love:
            return "lovecircle"
        }
    }
    
    var imageNoncircle: String {
        switch self {
        case .thank:
            return "thankcloud"
        case .sad:
            return "sadcloud"
        case .angry:
            return "angrycloud"
        case .comfort:
            return "comfortcloud"
        case .love:
            return "lovecloud"
        }
    }
        
}
