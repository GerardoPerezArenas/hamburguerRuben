//
//  SettingsView.swift
//  CifrasYLetrasApp
//
//  Vista de ajustes
//

import SwiftUI

/// Vista de ajustes de la aplicación
struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showResetAlert = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Ajustes")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.top, 20)
                
                // Sección de dificultad
                VStack(alignment: .leading, spacing: 16) {
                    Text("Nivel de dificultad predeterminado")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                        Button(action: {
                            viewModel.changeDifficulty(difficulty)
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(difficulty.rawValue)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color("PrimaryColor"))
                                    
                                    Text(difficulty.description)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("SecondaryTextColor"))
                                }
                                
                                Spacer()
                                
                                if viewModel.selectedDifficulty == difficulty {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("SecondaryColor"))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Botón de resetear estadísticas
                Button(action: {
                    showResetAlert = true
                }) {
                    Text("Resetear estadísticas")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .alert(isPresented: $showResetAlert) {
            Alert(
                title: Text("Resetear estadísticas"),
                message: Text("¿Estás seguro de que quieres borrar todas tus estadísticas? Esta acción no se puede deshacer."),
                primaryButton: .destructive(Text("Resetear")) {
                    viewModel.resetStats()
                },
                secondaryButton: .cancel(Text("Cancelar"))
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
