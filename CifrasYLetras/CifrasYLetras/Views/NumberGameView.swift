//
//  NumberGameView.swift
//  CifrasYLetras
//
//  View for the Numbers game (Cifras)
//

import SwiftUI

struct NumberGameView: View {
    let difficulty: DifficultyLevel
    
    @StateObject private var gameModel = NumberGameModel()
    @State private var gameEngine = NumberGameEngine()
    @State private var timer: Timer?
    @State private var showResults = false
    @State private var validationResult: (isValid: Bool, result: Int?, message: String)?
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.3),
                    Color.yellow.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Juego de Números")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(difficulty.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Timer
                    TimerView(timeRemaining: gameModel.timeRemaining)
                }
                .padding()
                
                if !gameModel.isGameActive {
                    // Start Game Button
                    VStack(spacing: 20) {
                        Text("¿Listo para el desafío?")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Button(action: startGame) {
                            Text("Iniciar Juego")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.orange)
                                        .shadow(radius: 5)
                                )
                        }
                        .padding(.horizontal, 40)
                    }
                } else {
                    // Game Active
                    ScrollView {
                        VStack(spacing: 25) {
                            // Target Number
                            VStack(spacing: 10) {
                                Text("Número Objetivo")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                Text("\(gameModel.targetNumber)")
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                                    .foregroundColor(.orange)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white)
                                            .shadow(radius: 5)
                                    )
                            }
                            
                            // Available Numbers
                            VStack(spacing: 10) {
                                Text("Números Disponibles")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 15) {
                                    ForEach(gameModel.availableNumbers, id: \.self) { number in
                                        NumberTile(number: number)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.9))
                                )
                            }
                            
                            // Solution Input
                            VStack(spacing: 10) {
                                Text("Tu Solución")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Ej: 50 + 25 × 2", text: $gameModel.playerSolution)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .padding(.horizontal)
                                
                                Text("Usa: + - × ÷")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            // Submit Button
                            Button(action: validateSolution) {
                                Text("Verificar Solución")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.orange)
                                    )
                            }
                            .padding(.horizontal)
                            
                            // Validation Result
                            if let result = validationResult {
                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: result.isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundColor(result.isValid ? .green : .red)
                                            .font(.title)
                                        
                                        Text(result.message)
                                            .font(.headline)
                                    }
                                    
                                    if let resultValue = result.result {
                                        Text("Resultado: \(resultValue)")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(radius: 3)
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showResults) {
            ResultsView(
                gameType: "Números",
                playerAnswer: gameModel.playerSolution,
                isCorrect: validationResult?.isValid ?? false,
                message: validationResult?.message ?? ""
            )
        }
    }
    
    private func startGame() {
        gameModel.startNewGame(difficulty: difficulty)
        validationResult = nil
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            gameModel.updateTimer()
            
            if gameModel.timeRemaining == 0 {
                timer?.invalidate()
                showResults = true
            }
        }
    }
    
    private func validateSolution() {
        let result = gameEngine.validateSolution(
            gameModel.playerSolution,
            with: gameModel.availableNumbers,
            target: gameModel.targetNumber
        )
        validationResult = result
        
        if result.isValid {
            timer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showResults = true
            }
        }
    }
}

// MARK: - Number Tile

struct NumberTile: View {
    let number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 3)
            )
    }
}

// MARK: - Timer View

struct TimerView: View {
    let timeRemaining: Int
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "clock.fill")
                .foregroundColor(timeRemaining <= 10 ? .red : .blue)
            
            Text(formatTime(timeRemaining))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(timeRemaining <= 10 ? .red : .primary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%d:%02d", mins, secs)
    }
}

#Preview {
    NavigationStack {
        NumberGameView(difficulty: .beginner)
    }
}
