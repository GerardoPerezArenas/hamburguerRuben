//
//  LetterTileView.swift
//  CifrasYLetrasApp
//
//  Vista de ficha de letra tipo Scrabble
//

import SwiftUI

/// Vista de ficha de letra estilo Scrabble
struct LetterTileView: View {
    let letter: String
    var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("SecondaryColor"))
                .frame(width: 60, height: 60)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
            
            Text(letter)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(Color("PrimaryColor"))
        }
        .scaleEffect(isSelected ? 0.9 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isSelected)
    }
}

struct LetterTileView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 8) {
            LetterTileView(letter: "A")
            LetterTileView(letter: "B", isSelected: true)
            LetterTileView(letter: "C")
        }
        .padding()
    }
}
