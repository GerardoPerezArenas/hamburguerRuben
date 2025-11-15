//
//  GameMode.swift
//  CifrasYLetrasApp
//
//  Modelo que define los dos modos de juego disponibles
//

import Foundation

/// Modos de juego disponibles en la aplicación
enum GameMode: String, Codable, CaseIterable {
    case cifras = "Cifras"
    case letras = "Letras"
    
    var description: String {
        switch self {
        case .cifras:
            return "Alcanza el número objetivo usando operaciones"
        case .letras:
            return "Forma la palabra más larga posible"
        }
    }
    
    var iconName: String {
        switch self {
        case .cifras:
            return "number.circle.fill"
        case .letras:
            return "textformat.abc"
        }
    }
}
