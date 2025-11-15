//
//  WordGameEngine.swift
//  CifrasYLetras
//
//  Game engine for validating word solutions
//

import Foundation

/// Handles the logic and validation for the word game
class WordGameEngine {
    private let dictionaryManager = DictionaryManager.shared
    
    /// Validate a player's word submission
    func validateWord(_ word: String, availableLetters: [Character]) -> (isValid: Bool, message: String, score: Int) {
        // Clean the input
        let cleaned = word.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        guard !cleaned.isEmpty else {
            return (false, "Introduce una palabra", 0)
        }
        
        guard cleaned.count >= 3 else {
            return (false, "La palabra debe tener al menos 3 letras", 0)
        }
        
        // Check if word can be formed from available letters
        guard canFormWord(cleaned, from: availableLetters) else {
            return (false, "No puedes formar esta palabra con las letras disponibles", 0)
        }
        
        // Check if word is in dictionary
        guard dictionaryManager.isValidWord(cleaned) else {
            return (false, "Esta palabra no está en el diccionario", 0)
        }
        
        // Calculate score based on word length
        let score = calculateScore(for: cleaned)
        return (true, "¡Palabra válida!", score)
    }
    
    /// Check if a word can be formed from available letters
    private func canFormWord(_ word: String, from letters: [Character]) -> Bool {
        var availableLetters = letters.map { String($0).uppercased() }
        
        for char in word {
            let charString = String(char)
            if let index = availableLetters.firstIndex(of: charString) {
                availableLetters.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// Calculate score for a word based on its length
    private func calculateScore(for word: String) -> Int {
        let length = word.count
        
        // Scoring system:
        // 3-4 letters: 1 point per letter
        // 5-6 letters: 2 points per letter
        // 7-8 letters: 3 points per letter
        // 9+ letters: 5 points per letter
        
        switch length {
        case 3...4:
            return length * 1
        case 5...6:
            return length * 2
        case 7...8:
            return length * 3
        default:
            return length * 5
        }
    }
    
    /// Find the best possible words from available letters
    func findBestWords(from letters: [Character], limit: Int = 5) -> [String] {
        let validWords = dictionaryManager.findValidWords(from: letters)
        return Array(validWords.prefix(limit))
    }
    
    /// Get a hint for the player
    func getHint(from letters: [Character]) -> String? {
        let validWords = dictionaryManager.findValidWords(from: letters)
        
        // Return a shorter word as a hint
        let hints = validWords.filter { $0.count >= 4 && $0.count <= 6 }
        return hints.randomElement()
    }
}
