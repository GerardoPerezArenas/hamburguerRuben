//
//  ResultsView.swift
//  CifrasYLetras
//
//  Results screen showing game outcome
//

import SwiftUI

struct ResultsView: View {
    let gameType: String
    let playerAnswer: String
    let isCorrect: Bool
    let message: String
    var score: Int? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    isCorrect ? Color.green.opacity(0.4) : Color.orange.opacity(0.4),
                    isCorrect ? Color.blue.opacity(0.4) : Color.red.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Result Icon
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(isCorrect ? .green : .orange)
                    .shadow(radius: 10)
                
                // Result Title
                Text(isCorrect ? "¡Excelente!" : "¡Buen Intento!")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                // Game Type
                Text("Juego de \(gameType)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // Result Details
                VStack(spacing: 20) {
                    // Player Answer
                    if !playerAnswer.isEmpty {
                        VStack(spacing: 8) {
                            Text("Tu Respuesta:")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text(playerAnswer)
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(radius: 3)
                                )
                        }
                    }
                    
                    // Message
                    Text(message)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.9))
                                .shadow(radius: 3)
                        )
                    
                    // Score
                    if let playerScore = score, playerScore > 0 {
                        VStack(spacing: 8) {
                            Text("Puntuación")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                                
                                Text("\(playerScore)")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(.green)
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 15) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Volver al Inicio")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue)
                                    .shadow(radius: 5)
                            )
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Success - Numbers") {
    NavigationStack {
        ResultsView(
            gameType: "Números",
            playerAnswer: "50 + 25 × 2",
            isCorrect: true,
            message: "¡Perfecto! Resultado exacto: 100"
        )
    }
}

#Preview("Success - Words") {
    NavigationStack {
        ResultsView(
            gameType: "Palabras",
            playerAnswer: "CASA",
            isCorrect: true,
            message: "¡Palabra válida!",
            score: 8
        )
    }
}

#Preview("Failed") {
    NavigationStack {
        ResultsView(
            gameType: "Números",
            playerAnswer: "25 + 25",
            isCorrect: false,
            message: "Resultado: 50 (diferencia: 50)"
        )
    }
}
