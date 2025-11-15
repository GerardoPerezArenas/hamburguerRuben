//
//  StatsView.swift
//  CifrasYLetrasApp
//
//  Vista de estadísticas del usuario
//

import SwiftUI

/// Vista de estadísticas del usuario
struct StatsView: View {
    @StateObject private var statsService = StatsService()
    @State private var userStats: UserStats
    
    init() {
        let service = StatsService()
        _userStats = State(initialValue: service.loadStats())
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Título
                    Text("Estadísticas")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.top, 20)
                    
                    // Resumen general
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            StatCard(
                                title: "Puntuación total",
                                value: "\(userStats.totalScore)"
                            )
                            
                            StatCard(
                                title: "Mejor puntuación",
                                value: "\(userStats.bestScore)"
                            )
                        }
                        
                        HStack(spacing: 16) {
                            StatCard(
                                title: "Partidas jugadas",
                                value: "\(userStats.gamesPlayed)"
                            )
                            
                            StatCard(
                                title: "Promedio",
                                value: userStats.gamesPlayed > 0 ?
                                    "\(userStats.totalScore / userStats.gamesPlayed)" : "0"
                            )
                        }
                        
                        HStack(spacing: 16) {
                            StatCard(
                                title: "Cifras jugadas",
                                value: "\(userStats.cifrasGamesPlayed)"
                            )
                            
                            StatCard(
                                title: "Letras jugadas",
                                value: "\(userStats.letrasGamesPlayed)"
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Historial reciente
                    if !userStats.scoreHistory.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Historial reciente")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("PrimaryColor"))
                                .padding(.horizontal, 24)
                            
                            ForEach(Array(userStats.scoreHistory.suffix(10).reversed()), id: \.id) { score in
                                ScoreHistoryRow(score: score)
                            }
                            .padding(.horizontal, 24)
                        }
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "chart.bar")
                                .font(.system(size: 60))
                                .foregroundColor(Color.gray.opacity(0.3))
                            
                            Text("Aún no has jugado ninguna partida")
                                .font(.system(size: 16))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        .padding(.vertical, 40)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitle("Estadísticas", displayMode: .inline)
        .onAppear {
            userStats = statsService.loadStats()
        }
    }
}

/// Fila de historial de puntuación
struct ScoreHistoryRow: View {
    let score: Score
    
    var body: some View {
        HStack(spacing: 16) {
            // Icono del modo
            Image(systemName: score.gameMode.iconName)
                .font(.system(size: 24))
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(score.gameMode.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("PrimaryColor"))
                
                Text(score.difficulty.rawValue)
                    .font(.system(size: 14))
                    .foregroundColor(Color("SecondaryTextColor"))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(score.points) pts")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("SecondaryColor"))
                
                Text(formatDate(score.date))
                    .font(.system(size: 12))
                    .foregroundColor(Color("SecondaryTextColor"))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsView()
        }
    }
}
