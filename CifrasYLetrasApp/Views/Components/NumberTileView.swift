//
//  NumberTileView.swift
//  CifrasYLetrasApp
//
//  Vista de ficha de número
//

import SwiftUI

/// Vista de ficha de número
struct NumberTileView: View {
    let number: Int
    var isUsed: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isUsed ? Color.gray.opacity(0.3) : Color("PrimaryColor"))
                .frame(width: 70, height: 70)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
            
            Text("\(number)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(isUsed ? .gray : .white)
        }
        .opacity(isUsed ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isUsed)
    }
}

struct NumberTileView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 12) {
            NumberTileView(number: 25)
            NumberTileView(number: 50, isUsed: true)
            NumberTileView(number: 7)
        }
        .padding()
    }
}
