//
//  DictionaryManager.swift
//  CifrasYLetras
//
//  Manages the Spanish dictionary for word validation
//

import Foundation

/// Manages loading and validation of Spanish words
class DictionaryManager {
    static let shared = DictionaryManager()
    
    private var dictionary: Set<String> = []
    private var isLoaded = false
    
    private init() {
        loadDictionary()
    }
    
    /// Load the Spanish dictionary from JSON file
    private func loadDictionary() {
        guard let url = Bundle.main.url(forResource: "spanish_dictionary", withExtension: "json") else {
            print("Failed to find spanish_dictionary.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([String].self, from: data)
            dictionary = Set(words.map { $0.uppercased() })
            isLoaded = true
            print("Dictionary loaded with \(dictionary.count) words")
        } catch {
            print("Failed to load dictionary: \(error)")
        }
    }
    
    /// Check if a word is valid in the Spanish dictionary
    func isValidWord(_ word: String) -> Bool {
        guard !word.isEmpty else { return false }
        let upperWord = word.uppercased()
        return dictionary.contains(upperWord)
    }
    
    /// Get all valid words that can be formed from the given letters
    func findValidWords(from letters: [Character]) -> [String] {
        var validWords: [String] = []
        let letterString = String(letters).uppercased()
        
        // This is a simplified version - in production, you'd use a more efficient algorithm
        for word in dictionary where word.count <= letters.count {
            if canFormWord(word, from: letters) {
                validWords.append(word)
            }
        }
        
        return validWords.sorted { $0.count > $1.count }
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
}
