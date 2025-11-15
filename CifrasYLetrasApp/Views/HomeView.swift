//
//  HomeView.swift
//  CifrasYLetrasApp
//
//  Vista principal de inicio
//

import SwiftUI

/// Vista principal de inicio de la aplicación
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    // Título
                    VStack(spacing: 8) {
                        Text("Cifras y Letras")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Text("El clásico concurso ahora en tu iPhone")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Botones principales
                    VStack(spacing: 16) {
                        PrimaryButton(title: "Jugar rápido", action: {
                            viewModel.startQuickGame()
                        })
                        
                        PrimaryButton(title: "Elegir modo", action: {
                            viewModel.showModeSelector()
                        }, style: .secondary)
                        
                        NavigationLink(destination: StatsView()) {
                            Text("Ver estadísticas")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color("PrimaryColor"))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    // Información de nivel actual
                    VStack(spacing: 12) {
                        Text("Nivel actual: \(viewModel.selectedDifficulty.rawValue)")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SecondaryTextColor"))
                        
                        Button(action: {
                            viewModel.showDifficultySelector()
                        }) {
                            Text("Ajustes")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("PrimaryColor"))
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
            .sheet(isPresented: $viewModel.showModeSelection) {
                ModeSelectionView(
                    onModeSelected: { mode in
                        viewModel.selectMode(mode)
                    }
                )
            }
            .sheet(isPresented: $viewModel.showDifficultySelection) {
                DifficultySelectionView(
                    selectedDifficulty: viewModel.selectedDifficulty,
                    onDifficultySelected: { difficulty in
                        viewModel.selectDifficulty(difficulty)
                    }
                )
            }
            .fullScreenCover(isPresented: $viewModel.showGame) {
                if let mode = viewModel.selectedMode {
                    GameView(
                        mode: mode,
                        difficulty: viewModel.selectedDifficulty,
                        onDismiss: {
                            viewModel.showGame = false
                            viewModel.refreshStats()
                        }
                    )
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.refreshStats()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
