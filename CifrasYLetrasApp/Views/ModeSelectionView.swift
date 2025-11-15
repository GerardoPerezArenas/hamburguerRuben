//
//  ModeSelectionView.swift
//  CifrasYLetrasApp
//
//  Vista de selección de modo de juego
//

import SwiftUI

/// Vista para seleccionar el modo de juego
struct ModeSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    let onModeSelected: (GameMode) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Text("Elige modo de juego")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    // Tarjetas de modo
                    VStack(spacing: 20) {
                        ForEach(GameMode.allCases, id: \.self) { mode in
                            ModeCard(mode: mode) {
                                onModeSelected(mode)
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

/// Tarjeta de modo de juego
struct ModeCard: View {
    let mode: GameMode
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                Image(systemName: mode.iconName)
                    .font(.system(size: 40))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 60)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(mode.rawValue)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text(mode.description)
                        .font(.system(size: 14))
                        .foregroundColor(Color("SecondaryTextColor"))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.gray.opacity(0.5))
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
}

struct ModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectionView(onModeSelected: { _ in })
    }
}
