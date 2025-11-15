//
//  WordGameView.swift
//  CifrasYLetras
//
//  View for the Word game (Letras)
//

import SwiftUI

struct WordGameView: View {
    let difficulty: DifficultyLevel
    
    @StateObject private var gameModel = WordGameModel()
    @State private var gameEngine = WordGameEngine()
    @State private var timer: Timer?
    @State private var showResults = false
    @State private var validationResult: (isValid: Bool, message: String, score: Int)?
    @State private var showHint = false
    @State private var hint: String?
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.green.opacity(0.3),
                    Color.blue.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Juego de Palabras")
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
                        Text("¿Listo para formar palabras?")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Button(action: startGame) {
                            Text("Iniciar Juego")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.green)
                                        .shadow(radius: 5)
                                )
                        }
                        .padding(.horizontal, 40)
                    }
                } else {
                    // Game Active
                    ScrollView {
                        VStack(spacing: 25) {
                            // Available Letters
                            VStack(spacing: 10) {
                                Text("Letras Disponibles")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                HStack(spacing: 12) {
                                    ForEach(Array(gameModel.availableLetters.enumerated()), id: \.offset) { _, letter in
                                        LetterTile(letter: letter)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.9))
                                        .shadow(radius: 3)
                                )
                            }
                            
                            // Word Input
                            VStack(spacing: 10) {
                                Text("Tu Palabra")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Escribe tu palabra aquí", text: $gameModel.playerWord)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title2)
                                    .autocapitalization(.allCharacters)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal)
                                
                                Text("Mínimo 3 letras")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            // Action Buttons
                            HStack(spacing: 15) {
                                Button(action: {
                                    hint = gameEngine.getHint(from: gameModel.availableLetters)
                                    showHint = true
                                }) {
                                    HStack {
                                        Image(systemName: "lightbulb.fill")
                                        Text("Pista")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.blue)
                                    )
                                }
                                
                                Button(action: validateWord) {
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                        Text("Verificar")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.green)
                                    )
                                }
                            }
                            .padding(.horizontal)
                            
                            // Hint Display
                            if showHint, let hintWord = hint {
                                VStack(spacing: 8) {
                                    HStack {
                                        Image(systemName: "lightbulb.fill")
                                            .foregroundColor(.yellow)
                                        Text("Pista")
                                            .font(.headline)
                                    }
                                    
                                    Text(hintWord)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(radius: 3)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Validation Result
                            if let result = validationResult {
                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: result.isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundColor(result.isValid ? .green : .red)
                                            .font(.title)
                                        
                                        VStack(alignment: .leading) {
                                            Text(result.message)
                                                .font(.headline)
                                            
                                            if result.isValid && result.score > 0 {
                                                Text("Puntuación: \(result.score) puntos")
                                                    .font(.subheadline)
                                                    .foregroundColor(.green)
                                            }
                                        }
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
                            
                            // Game Instructions
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Instrucciones:")
                                    .font(.headline)
                                
                                Text("• Forma la palabra más larga posible")
                                Text("• Usa solo las letras disponibles")
                                Text("• Cada letra solo se puede usar una vez")
                                Text("• Palabras más largas = más puntos")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.7))
                            )
                            .padding(.horizontal)
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
                gameType: "Palabras",
                playerAnswer: gameModel.playerWord,
                isCorrect: validationResult?.isValid ?? false,
                message: validationResult?.message ?? "",
                score: validationResult?.score
            )
        }
    }
    
    private func startGame() {
        gameModel.startNewGame(difficulty: difficulty)
        validationResult = nil
        showHint = false
        hint = nil
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
    
    private func validateWord() {
        let result = gameEngine.validateWord(
            gameModel.playerWord,
            availableLetters: gameModel.availableLetters
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

// MARK: - Letter Tile

struct LetterTile: View {
    let letter: Character
    
    var body: some View {
        Text(String(letter))
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 50, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.teal]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 3)
            )
    }
}

#Preview {
    NavigationStack {
        WordGameView(difficulty: .beginner)
    }
}
