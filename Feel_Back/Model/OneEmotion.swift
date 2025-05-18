

import Foundation
import SwiftData

@Model
class OneEmotion: Identifiable {
    @Attribute(.unique) var id: UUID
    var date: Date
    var emotion: Emotion
    var content: String
    @Relationship(deleteRule: .cascade) var comments: [Comment] = []
    
    init(id: UUID = UUID(), date: Date, emotion: Emotion, content: String) {
        self.id = id
        self.date = date
        self.emotion = emotion
        self.content = content 
    }
}


@Model
class Comment: Identifiable {
    @Attribute(.unique) var id: UUID
    var text: String
    var date: Date
    var emotion: OneEmotion

    init(id: UUID = UUID(), text: String, date: Date = Date(), emotion: OneEmotion) {
        self.id = id
        self.text = text
        self.date = date
        self.emotion = emotion
    }
}
