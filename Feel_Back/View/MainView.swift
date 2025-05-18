//
//  MainView.swift
//  FeelBack
//
//  Created by kim yijun on 4/14/25.
//

import SwiftUI
import SwiftData




struct MainView: View {
    
    @Environment(\.modelContext) private var context
 //   @Query(sort: \OneEmotion.date, order: .reverse) private var emotions: [OneEmotion]
    @StateObject private var uiState = UIState()
    @State private var filterEmotion: Emotion? = nil
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {

                Color.white
                    .ignoresSafeArea()

                VStack {
                    HStack(alignment: .center, spacing: -4) {
                        ForEach(Emotion.allCases, id: \.self) { emotion in
                            
                            NavigationLink(destination: FilteredEmotionView(filterEmotion: emotion)) {
                                Image(emotion.imageName)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            }

                        }
                    }
                    .padding(.horizontal)
                    

                    OneEmotionView()

                    Button {
                        uiState.showSheet = true
                    } label: {
                        Text("오늘 감정 기록하기")
                            .font(.feelbackfont(20))
                            .frame(width: 200)
                            .padding()
                            .background(Color.bluecolor)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .padding(.horizontal, 60)
                    }
                    .sheet(isPresented: $uiState.showSheet) {
                        SelectEmotionSheet()
                            .environmentObject(uiState)
                            .background(Color.white)
                    }
                }
                .padding(.top, 6)
            }
        }.tint(.bluecolor)
      
        
    }
}



struct SelectEmotionSheet: View {
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                emotionLink(emotion: .thank,
                            image: "thankcircle",
                            text: "💙고마운 하루를 보낸 땡큐구름💙",
                            explain: "작은 배려와 따뜻한 말에 마음이 포근해진 하루 ")

                emotionLink(emotion: .sad,
                            image: "sadcircle",
                            text: "💧 눈물이 맺힌 먹구름 💧",
                            explain: "마음이 무겁고 힘든 하루, 내 감정을 조용히 안아주는 시간")

                emotionLink(emotion: .angry,
                            image: "angrycircle",
                            text: "🔥 속이 끓는 화난구름 🔥",
                            explain: "답답하고 억울했던 순간, 감정을 솔직하게 풀어낸 하루 ")

                emotionLink(emotion: .comfort,
                            image: "comfortcircle",
                            text: "🌿 위로가 머문 편안구름 🌿",
                            explain: "작은 행복이나 쉼표 같은 순간에 마음이 풀린 하루")

                emotionLink(emotion: .love,
                            image: "lovecircle",
                            text: "💖 사랑을 느낀 따뜻구름 💖",
                            explain:"사랑하는 사람과 함께여서 특별했던 하루 ")
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("☁️ 오늘의 감정구름을 선택해주세요! ☁️")
                        .font(.feelbackfont(24))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 370)
        }.tint(.bluecolor)
    }

   @ViewBuilder
    private func emotionLink(emotion: Emotion, image: String, text: String, explain: String) -> some View {
        NavigationLink(destination: WriteEmotion(selectedEmotion: emotion)) {
            HStack(alignment: .center) {
                
                Image(image)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .padding(.trailing, 12)
                VStack(alignment: .leading) {
                    Text(text)
                        .font(.feelbackfont(18))
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    Text(explain)
                        .font(.feelbackfont(14))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
        }
    }
}


class UIState: ObservableObject {
    @Published var showSheet = false
}


#Preview {
    MainView()
        .modelContainer(for: [OneEmotion.self, Comment.self])
}
