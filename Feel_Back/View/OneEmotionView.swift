//
//  OneEmotionView.swift
//  FeelBack
//
//  Created by kim yijun on 4/15/25.
//
import SwiftUI
import SwiftData

struct OneEmotionView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \OneEmotion.date, order: .reverse) var emotions: [OneEmotion]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                if emotions.isEmpty {
                    VStack {
                        Spacer()
                        Text("아직 조용하지만, 곧 마음의 기록이 쌓여갈 거예요 ☁️")
                            .font(.feelbackfont(18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(emotions) { emotionEntry in
                            NavigationLink(destination: FullEmotionView(oneEmotion: emotionEntry)) {
                                HStack(alignment: .top) {
                                    Image(emotionEntry.emotion.imageName)
                                        .resizable()
                                        .frame(width: 70, height: 70)

                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(formattedDate(emotionEntry.date))
                                            .font(.feelbackfont(16))
                                            .foregroundColor(.gray)

                                        Text(emotionEntry.content)
                                            .font(.feelbackfont(20))
                                            .lineLimit(3)
                                            .foregroundColor(.black)
                                    }

                                    Spacer()
                                    
                                }
                                .padding()
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
                                    .padding(.all, 8)
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    if let index = emotions.firstIndex(of: emotionEntry) {
                                        deleteEmotion(at: IndexSet(integer: index))
                                    }
                                } label: {
                                        Image("trash")
                                } .tint(.clear)
                            }

                        }
                      
                        
                    }
                    .padding()
                    .frame(width: 380.0)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)


                    
                }
            }
        }.tint(.bluecolor)
    }

    func deleteEmotion(at offsets: IndexSet) {
        for index in offsets {
            let emotionEntry = emotions[index]
            context.delete(emotionEntry) 
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}


#Preview {
    OneEmotionView()
        .modelContainer(for: [OneEmotion.self, Comment.self])
}
