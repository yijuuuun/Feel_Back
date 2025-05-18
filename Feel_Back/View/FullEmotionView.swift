//
//  FullEmotionView.swift
//  FeelBack
//
//  Created by kim yijun on 4/16/25.
//
import SwiftUI
import SwiftData

struct FullEmotionView: View {
    
    @Environment(\.modelContext) private var context
    @Bindable var oneEmotion: OneEmotion
    
    var sortedComments: [Comment] {
        oneEmotion.comments.sorted { $0.date > $1.date }
    }
    
    @State private var isEditing = false
    @State private var editedContent: String = ""
    @FocusState private var isTextEditorFocused: Bool
    @FocusState private var editCommentFocused: Bool
    @State private var newCommentText: String = ""
    
    @State private var editingCommentId: UUID? = nil
    @State private var editingCommentText: String = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    Image(oneEmotion.emotion.imageName)
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Text(formattedDate(oneEmotion.date))
                        .font(.feelbackfont(16))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        if isEditing {
                            TextField("", text: $editedContent, axis: .vertical)
                                .focused($isTextEditorFocused)
                                .padding(5)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                                .font(.feelbackfont(20))
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Button("취소") {
                                    isEditing = false
                                }
                                .font(.feelbackfont(14))
                                .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button("저장") {
                                    if !editedContent.isEmpty {
                                        oneEmotion.content = editedContent
                                        try? context.save()
                                        isEditing = false
                                    }
                                }
                                .font(.feelbackfont(14))
                                .foregroundColor(.bluecolor)
                            }
                            .padding(.top, 5)
                        } else {
                            Text(oneEmotion.content)
                                .font(.feelbackfont(20))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    editedContent = oneEmotion.content
                                    isEditing = true
                                    isTextEditorFocused = true
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.gray)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 350)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
                    
                    if !isToday(oneEmotion.date) {
                        Divider().padding(.vertical, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("시간이 지나고 난 지금, 과거의 감정이 어떻게 느껴지나요?", text: $newCommentText, axis: .vertical)
                                .focused($isTextEditorFocused)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.15), radius: 5, x: 2, y: 2)
                                .font(.feelbackfont(16))
                                .multilineTextAlignment(.leading)
                                .onTapGesture {
                                    isTextEditorFocused = true
                                }
                            
                            HStack {
                                Spacer()
                                Button("댓글 남기기") {
                                    if !newCommentText.isEmpty {
                                        let comment = Comment(text: newCommentText, date: Date(), emotion: oneEmotion)
                                        self.oneEmotion.comments.append(comment)
                                        try? context.save()
                                        newCommentText = ""
                                        isTextEditorFocused = false
                                    }
                                }
                                .font(.feelbackfont(16))
                                .padding()
                                .background(Color.bluecolor)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                            }
                        }
                        .frame(width: 350)
                        
                        Text("시간 지난 후, 든 생각")
                            .font(.feelbackfont(18))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            ForEach(sortedComments, id: \.self) { comment in
                                commentView(for: comment)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, isToday(oneEmotion.date) ? 100 : 10)
            }
            .background(Rectangle().fill(.white))
            .onTapGesture {
                self.isTextEditorFocused = false
                self.editCommentFocused = false
                if isEditing {
                    oneEmotion.content = editedContent
                    isEditing = false
                }
                editingCommentId = nil
            }
        }
        .tint(.bluecolor)
    }
    
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }

    func commentView(for comment: Comment) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            if editingCommentId == comment.id {
                TextField("", text: $editingCommentText, axis: .vertical)
                    .focused($isTextEditorFocused)
                    .padding(5)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .font(.feelbackfont(16))
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Button("취소") {
                        editingCommentId = nil
                    }
                    .font(.feelbackfont(14))
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("저장") {
                        if !editingCommentText.isEmpty {
                            comment.text = editingCommentText
                            comment.date = Date()
                            try? context.save()
                            editingCommentId = nil
                            isTextEditorFocused = false
                        }
                    }
                    .font(.feelbackfont(14))
                    .foregroundColor(.bluecolor)
                }
                .padding(.top, 5)
            } else {
                Text(comment.text)
                    .font(.feelbackfont(16))
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(formattedDate(comment.date))
                        .font(.feelbackfont(12))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        editingCommentId = comment.id
                        editingCommentText = comment.text
                        editCommentFocused = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        context.delete(comment)
                        try? context.save()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                    .padding(.leading, 8)
                }
            }
        }
        .padding()
        .frame(width: 350)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.15), radius: 5, x: 2, y: 2)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}



#Preview {
    FullEmotionView(oneEmotion: OneEmotion(id: UUID(), date: Date(), emotion: .thank, content: "Sample content"))
        .modelContainer(for: [OneEmotion.self, Comment.self])
}
