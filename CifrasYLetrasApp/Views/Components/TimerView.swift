//
//  TimerView.swift
//  CifrasYLetrasApp
//
//  Vista del cronómetro
//

import SwiftUI

/// Vista del cronómetro con animaciones
struct TimerView: View {
    let timeRemaining: Int
    let totalTime: Int
    
    private var isLowTime: Bool {
        timeRemaining <= 10
    }
    
    private var progress: Double {
        Double(timeRemaining) / Double(totalTime)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "clock.fill")
                .foregroundColor(isLowTime ? .red : Color("PrimaryColor"))
                .scaleEffect(isLowTime ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isLowTime)
            
            Text("\(timeRemaining)s")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(isLowTime ? .red : Color("PrimaryColor"))
                .monospacedDigit()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isLowTime ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
        )
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            TimerView(timeRemaining: 45, totalTime: 60)
            TimerView(timeRemaining: 8, totalTime: 60)
        }
        .padding()
    }
}
