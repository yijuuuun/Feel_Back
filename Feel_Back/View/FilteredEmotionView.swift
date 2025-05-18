//
//  FilteredEmotionView.swift
//  FeelBack
//
//  Created by kim yijun on 4/21/25.
//


import SwiftUI
import SwiftData

struct FilteredEmotionView: View {
    
    
    @Environment(\.modelContext) private var context
    @Query(sort: \OneEmotion.date, order: .reverse) private var emotions: [OneEmotion]
    
    var filterEmotion: Emotion
    
    

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Image(filterEmotion.imageNoncircle)
                        .resizable()
                        .frame(width: 43.652, height: 32.529)
                    Text("\(filterEmotion.title) 기록")
                        .font(.feelbackfont(22))
                    Image(filterEmotion.imageNoncircle)
                        .resizable()
                        .frame(width: 43.652, height: 32.529)
                       
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(width: 300)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 2, y: 2)
                
                
                if emotions.filter({ $0.emotion == filterEmotion}).isEmpty {
                    VStack {
                        Spacer()
                        Text("아직 조용하지만, 곧 \(filterEmotion.title)의 기록이 쌓여갈 거예요 ☁️")
                            .font(.feelbackfont(18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }

                }
                else{
                    List {
                        ForEach( emotions.filter { $0.emotion == filterEmotion }){ emotionEntry in
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
                    .frame(width: 380)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
               
            }
        }  
     
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
    FilteredEmotionView(filterEmotion: .love)
}
