//
//  DifficultySelectionView.swift
//  CifrasYLetrasApp
//
//  Vista de selección de nivel de dificultad
//

import SwiftUI

/// Vista para seleccionar el nivel de dificultad
struct DifficultySelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    let selectedDifficulty: DifficultyLevel
    let onDifficultySelected: (DifficultyLevel) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Text("Selecciona dificultad")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    // Tarjetas de dificultad
                    VStack(spacing: 16) {
                        ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                            DifficultyCard(
                                difficulty: difficulty,
                                isSelected: difficulty == selectedDifficulty
                            ) {
                                onDifficultySelected(difficulty)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

/// Tarjeta de nivel de dificultad
struct DifficultyCard: View {
    let difficulty: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(difficulty.rawValue)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }
                    
                    Text(difficulty.description)
                        .font(.system(size: 14))
                        .foregroundColor(Color("SecondaryTextColor"))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(difficulty.cifrasTime)s")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text("tiempo")
                        .font(.system(size: 12))
                        .foregroundColor(Color("SecondaryTextColor"))
                }
            }
            .padding(20)
            .background(
                isSelected ?
                    Color("SecondaryColor").opacity(0.2) :
                    Color.white
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ?
                            Color("SecondaryColor") :
                            Color.gray.opacity(0.2),
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct DifficultySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultySelectionView(
            selectedDifficulty: .intermedio,
            onDifficultySelected: { _ in }
        )
    }
}
