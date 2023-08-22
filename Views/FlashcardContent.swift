

import SwiftUI

struct FlashcardListView: View {
    let flashcards: [(english: String, ukrainian: String)]
    
    var body: some View {
        List {
            ForEach(flashcards, id: \.english) { flashcard in
                FlashcardView(english: flashcard.english, ukrainian: flashcard.ukrainian)
            }
        }
        .navigationBarTitle("Flashcards")
    }
}

struct FlashcardView: View {
    let english: String
    let ukrainian: String
    
    @State private var showingEnglish = true
    
    var body: some View {
        ZStack {
            Text(showingEnglish ? english : ukrainian)
            
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("Color 4"))
                .padding()
                .navigationBarTitleDisplayMode(.inline)

                .rotation3DEffect(.degrees(showingEnglish ? 0 : 360), axis: (x: 0, y: 1, z: 0))
                .onTapGesture {
                    withAnimation {
                        showingEnglish.toggle()
                    }
                }
        }
        .frame(width: 300, height: 200)
        .background(Color("background"))
        .cornerRadius(10)
        .shadow(radius: 5)
        .navigationBarTitleDisplayMode(.inline)
    }
}
