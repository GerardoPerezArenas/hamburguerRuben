//
//  ResultsView.swift
//  CifrasYLetrasApp
//
//  Vista de resultados del juego
//

import SwiftUI

/// Vista que muestra los resultados del juego
struct ResultsView: View {
    let cifrasState: CifrasGameState?
    let letrasState: LetrasGameState?
    let suggestions: [String]?
    let possibleWords: [String]?
    let onDismiss: () -> Void
    let onPlayAgain: () -> Void
    
    @StateObject private var viewModel: ResultsViewModel
    
    init(cifrasState: CifrasGameState? = nil,
         letrasState: LetrasGameState? = nil,
         suggestions: [String]? = nil,
         possibleWords: [String]? = nil,
         onDismiss: @escaping () -> Void,
         onPlayAgain: @escaping () -> Void) {
        
        self.cifrasState = cifrasState
        self.letrasState = letrasState
        self.suggestions = suggestions
        self.possibleWords = possibleWords
        self.onDismiss = onDismiss
        self.onPlayAgain = onPlayAgain
        
        _viewModel = StateObject(wrappedValue: ResultsViewModel(
            cifrasState: cifrasState,
            letrasState: letrasState
        ))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Título
                        Text("Resultados")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top, 40)
                        
                        // Mensaje de resultado
                        Text(viewModel.getResultMessage())
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("SecondaryColor"))
                        
                        // Puntuación
                        VStack(spacing: 8) {
                            Text("\(viewModel.score)")
                                .font(.system(size: 64, weight: .bold, design: .rounded))
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Text("Puntos obtenidos")
                                .font(.system(size: 16))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        .padding(.vertical, 20)
                        
                        // Detalles específicos del modo
                        if let cifras = cifrasState {
                            CifrasResultsDetail(state: cifras, suggestions: suggestions ?? [])
                        } else if let letras = letrasState {
                            LetrasResultsDetail(state: letras, possibleWords: possibleWords ?? [])
                        }
                        
                        // Estadísticas totales
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Estadísticas totales")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color("PrimaryColor"))
                            
                            let stats = viewModel.getTotalStats()
                            
                            HStack {
                                StatCard(title: "Puntuación total", value: "\(stats.totalScore)")
                                StatCard(title: "Mejor puntuación", value: "\(stats.bestScore)")
                            }
                            
                            HStack {
                                StatCard(title: "Partidas jugadas", value: "\(stats.gamesPlayed)")
                                StatCard(title: "Cifras", value: "\(stats.cifrasGamesPlayed)")
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        
                        // Botones
                        VStack(spacing: 12) {
                            PrimaryButton(title: "Volver a jugar") {
                                onPlayAgain()
                            }
                            
                            PrimaryButton(title: "Ir al menú", style: .secondary) {
                                onDismiss()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

/// Detalles de resultado para Cifras
struct CifrasResultsDetail: View {
    let state: CifrasGameState
    let suggestions: [String]
    
    var body: some View {
        VStack(spacing: 16) {
            // Resultado del usuario
            ResultDetailRow(
                label: "Tu resultado",
                value: state.userResult != nil ? "\(state.userResult!)" : "—"
            )
            
            ResultDetailRow(
                label: "Objetivo",
                value: "\(state.targetNumber)"
            )
            
            if let result = state.userResult {
                ResultDetailRow(
                    label: "Diferencia",
                    value: "\(abs(state.targetNumber - result))"
                )
            }
            
            // Sugerencias
            if !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Soluciones aproximadas")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    ForEach(suggestions.prefix(3), id: \.self) { suggestion in
                        Text(suggestion)
                            .font(.system(size: 14, design: .monospaced))
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 24)
    }
}

/// Detalles de resultado para Letras
struct LetrasResultsDetail: View {
    let state: LetrasGameState
    let possibleWords: [String]
    
    var body: some View {
        VStack(spacing: 16) {
            // Palabras encontradas
            if !state.usedWords.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tus palabras")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    ForEach(state.usedWords, id: \.self) { word in
                        HStack {
                            Text(word)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Spacer()
                            
                            Text("\(word.count) pts")
                                .font(.system(size: 14))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
            
            // Palabras posibles
            if !possibleWords.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ejemplos de palabras más largas")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    ForEach(possibleWords.prefix(5), id: \.self) { word in
                        HStack {
                            Text(word)
                                .font(.system(size: 16))
                                .foregroundColor(Color("SecondaryTextColor"))
                            
                            Spacer()
                            
                            Text("\(word.count) letras")
                                .font(.system(size: 12))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 24)
    }
}

/// Fila de detalle de resultado
struct ResultDetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(Color("SecondaryTextColor"))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("PrimaryColor"))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

/// Tarjeta de estadística
struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("PrimaryColor"))
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color("SecondaryTextColor"))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let cifrasState = CifrasGameState(
            difficulty: .intermedio,
            availableNumbers: [25, 50, 7, 3, 2, 8],
            targetNumber: 453
        )
        
        return ResultsView(
            cifrasState: cifrasState,
            suggestions: ["25 + 50 = 75"],
            onDismiss: {},
            onPlayAgain: {}
        )
    }
}
