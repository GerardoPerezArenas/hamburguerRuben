//
//  HomeView.swift
//  CifrasYLetras
//
//  Home screen with game mode selection
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDifficulty: DifficultyLevel = .beginner
    @State private var showNumberGame = false
    @State private var showWordGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.6),
                        Color.purple.opacity(0.6)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Title
                    VStack(spacing: 10) {
                        Text("Cifras y Letras")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("El clásico juego de TV")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // Difficulty Selection
                    VStack(spacing: 15) {
                        Text("Selecciona la Dificultad")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        ForEach(DifficultyLevel.allCases) { difficulty in
                            DifficultyButton(
                                difficulty: difficulty,
                                isSelected: selectedDifficulty == difficulty
                            ) {
                                selectedDifficulty = difficulty
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // Game Mode Buttons
                    VStack(spacing: 20) {
                        GameModeButton(
                            title: "Juego de Números",
                            subtitle: "Alcanza el número objetivo",
                            icon: "number.square.fill",
                            color: .orange
                        ) {
                            showNumberGame = true
                        }
                        
                        GameModeButton(
                            title: "Juego de Palabras",
                            subtitle: "Forma la palabra más larga",
                            icon: "textformat.abc",
                            color: .green
                        ) {
                            showWordGame = true
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
            }
            .navigationDestination(isPresented: $showNumberGame) {
                NumberGameView(difficulty: selectedDifficulty)
            }
            .navigationDestination(isPresented: $showWordGame) {
                WordGameView(difficulty: selectedDifficulty)
            }
        }
    }
}

// MARK: - Difficulty Button

struct DifficultyButton: View {
    let difficulty: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(difficulty.icon)
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(difficulty.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(difficulty.description)
                        .font(.caption)
                        .opacity(0.8)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.white : Color.white.opacity(0.9))
                    .shadow(color: .black.opacity(isSelected ? 0.3 : 0.1), radius: isSelected ? 8 : 4)
            )
            .foregroundColor(.primary)
        }
    }
}

// MARK: - Game Mode Button

struct GameModeButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        Circle()
                            .fill(color.opacity(0.3))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .opacity(0.9)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                    .shadow(color: color.opacity(0.5), radius: 10)
            )
            .foregroundColor(.white)
        }
    }
}

#Preview {
    HomeView()
}
