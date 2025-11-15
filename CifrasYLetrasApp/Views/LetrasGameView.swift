//
//  LetrasGameView.swift
//  CifrasYLetrasApp
//
//  Vista del juego de Letras
//

import SwiftUI

/// Vista del juego de Letras
struct LetrasGameView: View {
    @StateObject private var viewModel: LetrasViewModel
    @Environment(\.presentationMode) var presentationMode
    let onDismiss: () -> Void
    
    init(difficulty: DifficultyLevel, onDismiss: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LetrasViewModel(difficulty: difficulty))
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Barra superior
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        onDismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    
                    Spacer()
                    
                    Text("Letras — \(viewModel.gameState.difficulty.rawValue)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Spacer()
                    
                    TimerView(
                        timeRemaining: viewModel.timeRemaining,
                        totalTime: viewModel.gameState.difficulty.letrasTime
                    )
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Instrucción
                Text("Forma la palabra más larga posible")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("SecondaryTextColor"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Letras disponibles
                VStack(spacing: 16) {
                    Text("Letras disponibles")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                        ForEach(viewModel.gameState.availableLetters, id: \.self) { letter in
                            Button(action: {
                                if viewModel.isGameActive {
                                    viewModel.addLetter(letter)
                                }
                            }) {
                                LetterTileView(letter: letter)
                            }
                            .disabled(!viewModel.isGameActive)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                
                // Palabra actual
                VStack(spacing: 12) {
                    Text("Tu palabra")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    Text(viewModel.currentWord.isEmpty ? "—" : viewModel.currentWord)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                // Botones de control
                HStack(spacing: 12) {
                    Button(action: {
                        viewModel.backspace()
                    }) {
                        Label("Borrar", systemImage: "delete.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .disabled(!viewModel.isGameActive)
                    
                    Button(action: {
                        viewModel.clear()
                    }) {
                        Label("Limpiar", systemImage: "trash")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .disabled(!viewModel.isGameActive)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Mensajes
                VStack(spacing: 8) {
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                    }
                    
                    if let success = viewModel.successMessage {
                        Text(success)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.green)
                    }
                    
                    // Pista (solo para principiante)
                    if let hint = viewModel.getHint(), viewModel.isGameActive {
                        Text("💡 \(hint)")
                            .font(.system(size: 12))
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                }
                .padding(.horizontal)
                .frame(height: 60)
                
                // Puntuación actual
                if viewModel.gameState.score > 0 {
                    Text("Puntuación actual: \(viewModel.gameState.score) puntos")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                }
                
                // Botones de acción
                VStack(spacing: 12) {
                    PrimaryButton(title: "Validar palabra") {
                        viewModel.validateWord()
                    }
                    .disabled(!viewModel.isGameActive || viewModel.currentWord.isEmpty)
                    
                    if viewModel.isGameActive {
                        Button(action: {
                            viewModel.endGame()
                        }) {
                            Text("Finalizar juego")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $viewModel.showResults) {
            ResultsView(
                letrasState: viewModel.gameState,
                possibleWords: viewModel.getPossibleWords(),
                onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                    onDismiss()
                },
                onPlayAgain: {
                    presentationMode.wrappedValue.dismiss()
                    onDismiss()
                }
            )
        }
    }
}

struct LetrasGameView_Previews: PreviewProvider {
    static var previews: some View {
        LetrasGameView(difficulty: .intermedio, onDismiss: {})
    }
}
