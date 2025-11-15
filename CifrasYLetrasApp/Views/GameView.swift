//
//  GameView.swift
//  CifrasYLetrasApp
//
//  Vista que coordina el juego según el modo seleccionado
//

import SwiftUI

/// Vista coordinadora que muestra el juego correspondiente según el modo
struct GameView: View {
    let mode: GameMode
    let difficulty: DifficultyLevel
    let onDismiss: () -> Void
    
    var body: some View {
        Group {
            switch mode {
            case .cifras:
                CifrasGameView(difficulty: difficulty, onDismiss: onDismiss)
            case .letras:
                LetrasGameView(difficulty: difficulty, onDismiss: onDismiss)
            }
        }
    }
}
