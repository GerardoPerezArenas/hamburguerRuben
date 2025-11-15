//
//  CifrasGameView.swift
//  CifrasYLetrasApp
//
//  Vista del juego de Cifras
//

import SwiftUI

/// Vista del juego de Cifras (números)
struct CifrasGameView: View {
    @StateObject private var viewModel: CifrasViewModel
    @Environment(\.presentationMode) var presentationMode
    let onDismiss: () -> Void
    
    init(difficulty: DifficultyLevel, onDismiss: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: CifrasViewModel(difficulty: difficulty))
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
                    
                    Text("Cifras — \(viewModel.gameState.difficulty.rawValue)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Spacer()
                    
                    TimerView(
                        timeRemaining: viewModel.timeRemaining,
                        totalTime: viewModel.gameState.difficulty.cifrasTime
                    )
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Número objetivo
                VStack(spacing: 8) {
                    Text("Objetivo")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    Text("\(viewModel.gameState.targetNumber)")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                }
                .padding(.vertical, 20)
                
                // Números disponibles
                VStack(spacing: 12) {
                    Text("Números disponibles")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                        ForEach(viewModel.gameState.availableNumbers, id: \.self) { number in
                            Button(action: {
                                if viewModel.isGameActive {
                                    viewModel.addNumber(number)
                                }
                            }) {
                                NumberTileView(number: number)
                            }
                            .disabled(!viewModel.isGameActive)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                // Campo de expresión
                VStack(spacing: 12) {
                    Text("Tu expresión")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    Text(viewModel.currentExpression.isEmpty ? "—" : viewModel.currentExpression)
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                // Teclado de operaciones
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        ForEach(["+", "−", "×", "÷"], id: \.self) { op in
                            OperationButton(symbol: op) {
                                if viewModel.isGameActive {
                                    viewModel.addOperation(op)
                                }
                            }
                            .disabled(!viewModel.isGameActive)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        OperationButton(symbol: "(", width: 80) {
                            if viewModel.isGameActive {
                                viewModel.addOperation("(")
                            }
                        }
                        .disabled(!viewModel.isGameActive)
                        
                        OperationButton(symbol: ")", width: 80) {
                            if viewModel.isGameActive {
                                viewModel.addOperation(")")
                            }
                        }
                        .disabled(!viewModel.isGameActive)
                        
                        OperationButton(symbol: "←", width: 80) {
                            viewModel.backspace()
                        }
                        .disabled(!viewModel.isGameActive)
                        
                        OperationButton(symbol: "C", width: 80) {
                            viewModel.clear()
                        }
                        .disabled(!viewModel.isGameActive)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Mensaje de error
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                // Botón validar
                PrimaryButton(title: "Validar solución") {
                    viewModel.validateSolution()
                }
                .disabled(!viewModel.isGameActive || viewModel.currentExpression.isEmpty)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $viewModel.showResults) {
            ResultsView(
                cifrasState: viewModel.gameState,
                suggestions: viewModel.getSuggestions(),
                onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                    onDismiss()
                },
                onPlayAgain: {
                    // Crear nuevo juego
                    presentationMode.wrappedValue.dismiss()
                    onDismiss()
                }
            )
        }
    }
}

/// Botón de operación
struct OperationButton: View {
    let symbol: String
    var width: CGFloat? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(symbol)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color("PrimaryColor"))
                .frame(maxWidth: width == nil ? .infinity : width)
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct CifrasGameView_Previews: PreviewProvider {
    static var previews: some View {
        CifrasGameView(difficulty: .intermedio, onDismiss: {})
    }
}
