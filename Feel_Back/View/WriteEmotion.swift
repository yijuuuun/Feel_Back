//
//  WriteEmotion.swift
//  FeelBack
//
//  Created by kim yijun on 4/15/25.
//
import SwiftUI
import SwiftData

struct WriteEmotion: View {
    
    @State var selectedEmotion: Emotion
    @State private var fullText: String = ""
    @EnvironmentObject var uiState: UIState
    @Environment(\.modelContext) private var context
   // @Environment(\.dismiss) private var dismiss
    

    var body: some View {
        ZStack(alignment: .top) {
            Color.white
               .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack(alignment: .center, spacing: 20) {
                Image(selectedEmotion.imageName)
                    .resizable()
                    .frame(width: 75, height: 75)
                
                HStack {
                    Text(instructionText(for: selectedEmotion))
                        .padding()
                        .frame(width: 300)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
                        .font(.feelbackfont(18))
                        
                }
                
                Text(formattedDate)
                    .font(.feelbackfont(16))
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $fullText)
                        .frame(width: 300, height: 200)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
                        .font(.feelbackfont(20))
                        
                    if fullText.isEmpty {
                        Text("기록을 시작해보세요")
                            .foregroundColor(.gray)
                            .font(.feelbackfont(20))
                            .padding(.vertical, 20)
                            .padding(.leading, 7)
                    }
                }
                .padding(.bottom, 30)
                
                Button("작성 완료") {
                    let newEmotion = OneEmotion(id: UUID(), date: Date(), emotion: selectedEmotion, content: fullText)
                    context.insert(newEmotion)
                    uiState.showSheet = false
                }
                .font(.feelbackfont(20))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bluecolor)
                .foregroundColor(.white)
                .cornerRadius(50)
                .padding(.horizontal, 80)
            }
            .padding(.top, 80)
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
    func instructionText(for emotion: Emotion) -> String {
        switch emotion {
        case .thank:
            return "오늘 감사한 감정을 느끼며 생각한 것들을 적어보세요."
        case .sad:
            return "오늘 마음을 울린 슬픔이나 힘든 감정을 솔직하게 표현해보세요."
        case .angry:
            return "무엇이 나를 화나게 했는지, 그 감정을 어떻게 느꼈는지 적어보세요."
        case .comfort:
            return "오늘 마음을 편안하게 해준 순간들을 떠올리며 기록해보세요."
        case .love:
            return "사랑을 느낀 순간과 그 감정을 글로 남겨보세요."
        }
    }
}


#Preview {
    let container = try! ModelContainer(for: OneEmotion.self, Comment.self)
    let context = ModelContext(container)
    WriteEmotion(selectedEmotion: .thank)
        .environment(\.modelContext, context)
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
