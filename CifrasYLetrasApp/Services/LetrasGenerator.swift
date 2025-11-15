//
//  LetrasGenerator.swift
//  CifrasYLetrasApp
//
//  Generador de letras para el modo Letras
//

import Foundation

/// Generador de letras con distribución realista del español
class LetrasGenerator {
    
    // Distribución de frecuencias del español
    private let vowels: [String] = ["A", "E", "I", "O", "U"]
    
    // Consonantes frecuentes
    private let commonConsonants: [String] = ["N", "S", "R", "L", "T", "D", "C", "M", "P", "B"]
    
    // Consonantes medianamente frecuentes
    private let mediumConsonants: [String] = ["G", "H", "F", "V", "Y", "Q", "J"]
    
    // Consonantes raras
    private let rareConsonants: [String] = ["Z", "X", "Ñ", "K", "W"]
    
    /// Genera un conjunto de letras según el nivel de dificultad
    /// - Parameter difficulty: Nivel de dificultad
    /// - Returns: Array de letras (Strings) para usar en el juego
    func generateLetters(for difficulty: DifficultyLevel) -> [String] {
        let count = difficulty.lettersCount
        var letters: [String] = []
        
        switch difficulty {
        case .principiante:
            // Distribución favorable: más vocales y consonantes comunes
            let vowelCount = Int.random(in: 3...4)
            letters.append(contentsOf: Array(vowels.shuffled().prefix(vowelCount)))
            
            let remaining = count - vowelCount
            letters.append(contentsOf: Array(commonConsonants.shuffled().prefix(remaining)))
            
        case .intermedio:
            // Distribución balanceada
            let vowelCount = Int.random(in: 3...4)
            letters.append(contentsOf: Array(vowels.shuffled().prefix(vowelCount)))
            
            let remaining = count - vowelCount
            let commonCount = Int.random(in: (remaining - 2)...remaining)
            letters.append(contentsOf: Array(commonConsonants.shuffled().prefix(commonCount)))
            
            if remaining > commonCount {
                letters.append(contentsOf: Array(mediumConsonants.shuffled().prefix(remaining - commonCount)))
            }
            
        case .profesional:
            // Distribución realista con algunas letras difíciles
            let vowelCount = Int.random(in: 2...4)
            letters.append(contentsOf: Array(vowels.shuffled().prefix(vowelCount)))
            
            let remaining = count - vowelCount
            let commonCount = Int.random(in: 3...(remaining - 1))
            let mediumCount = Int.random(in: 1...(remaining - commonCount - 1))
            let rareCount = remaining - commonCount - mediumCount
            
            letters.append(contentsOf: Array(commonConsonants.shuffled().prefix(commonCount)))
            letters.append(contentsOf: Array(mediumConsonants.shuffled().prefix(mediumCount)))
            
            if rareCount > 0 {
                letters.append(contentsOf: Array(rareConsonants.shuffled().prefix(rareCount)))
            }
        }
        
        return letters.shuffled()
    }
    
    /// Verifica si una palabra puede formarse con las letras disponibles
    /// - Parameters:
    ///   - word: Palabra a verificar
    ///   - letters: Letras disponibles
    /// - Returns: true si la palabra puede formarse
    func canFormWord(_ word: String, with letters: [String]) -> Bool {
        var availableLetters = letters
        let wordLetters = word.uppercased().map { String($0) }
        
        for letter in wordLetters {
            if let index = availableLetters.firstIndex(of: letter) {
                availableLetters.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// Encuentra posibles palabras largas que se pueden formar (simplificado)
    /// En producción esto consultaría el diccionario completo
    /// - Parameter letters: Letras disponibles
    /// - Returns: Array de palabras sugeridas
    func findPossibleWords(with letters: [String]) -> [String] {
        // Esta es una implementación simplificada
        // En producción, consultaría el diccionario completo
        
        let exampleWords = [
            "CASA", "MESA", "AMOR", "CAMPO", "TIEMPO", "PALABRA",
            "ESTRELLA", "VENTANA", "CORAZÓN", "LIBERTAD"
        ]
        
        return exampleWords.filter { canFormWord($0, with: letters) }
    }
}
