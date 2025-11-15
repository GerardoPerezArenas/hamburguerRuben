# Code Samples - Cifras y Letras

This document provides code samples demonstrating key features and patterns used in the application.

## 1. Creating a New Game Model

```swift
import Foundation
import Combine

class NumberGameModel: ObservableObject {
    // Published properties automatically notify views of changes
    @Published var availableNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var timeRemaining: Int = 0
    
    func startNewGame(difficulty: DifficultyLevel) {
        self.timeRemaining = difficulty.timerDuration
        generateNumbers(for: difficulty)
        generateTargetNumber(for: difficulty)
    }
}
```

## 2. SwiftUI View with Navigation

```swift
struct HomeView: View {
    @State private var selectedDifficulty: DifficultyLevel = .beginner
    @State private var showNumberGame = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Difficulty selection UI
                ForEach(DifficultyLevel.allCases) { difficulty in
                    Button(action: {
                        selectedDifficulty = difficulty
                    }) {
                        Text(difficulty.rawValue)
                    }
                }
                
                // Navigate to game
                Button("Start Number Game") {
                    showNumberGame = true
                }
            }
            .navigationDestination(isPresented: $showNumberGame) {
                NumberGameView(difficulty: selectedDifficulty)
            }
        }
    }
}
```

## 3. Timer Implementation

```swift
class GameView: View {
    @StateObject private var gameModel = NumberGameModel()
    @State private var timer: Timer?
    
    private func startTimer() {
        timer?.invalidate() // Clean up any existing timer
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            gameModel.updateTimer()
            
            if gameModel.timeRemaining == 0 {
                timer?.invalidate()
                endGame()
            }
        }
    }
    
    private func endGame() {
        gameModel.endGame()
        showResults = true
    }
}
```

## 4. Dictionary Management

```swift
class DictionaryManager {
    static let shared = DictionaryManager()
    private var dictionary: Set<String> = []
    
    private init() {
        loadDictionary()
    }
    
    private func loadDictionary() {
        guard let url = Bundle.main.url(forResource: "spanish_dictionary", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([String].self, from: data)
            dictionary = Set(words.map { $0.uppercased() })
        } catch {
            print("Failed to load dictionary: \(error)")
        }
    }
    
    func isValidWord(_ word: String) -> Bool {
        return dictionary.contains(word.uppercased())
    }
}
```

## 5. Expression Validation

```swift
class NumberGameEngine {
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case multiply = "×"
        case divide = "÷"
        
        func apply(_ a: Int, _ b: Int) -> Int? {
            switch self {
            case .add:
                return a + b
            case .subtract:
                return a >= b ? a - b : nil
            case .multiply:
                return a * b
            case .divide:
                return (b != 0 && a % b == 0) ? a / b : nil
            }
        }
    }
    
    func validateSolution(_ solution: String, with numbers: [Int], target: Int) 
        -> (isValid: Bool, result: Int?, message: String) {
        
        let components = solution.components(separatedBy: " ")
        
        if let result = evaluateExpression(components, availableNumbers: numbers) {
            let difference = abs(result - target)
            
            if result == target {
                return (true, result, "¡Perfecto! Resultado exacto: \(result)")
            } else {
                return (true, result, "Resultado: \(result) (diferencia: \(difference))")
            }
        }
        
        return (false, nil, "Expresión inválida")
    }
}
```

## 6. Reusable UI Components

```swift
struct NumberTile: View {
    let number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.orange, .red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 3)
            )
    }
}

// Usage:
LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 15) {
    ForEach(gameModel.availableNumbers, id: \.self) { number in
        NumberTile(number: number)
    }
}
```

## 7. Word Validation

```swift
class WordGameEngine {
    private let dictionaryManager = DictionaryManager.shared
    
    func validateWord(_ word: String, availableLetters: [Character]) 
        -> (isValid: Bool, message: String, score: Int) {
        
        let cleaned = word.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        guard cleaned.count >= 3 else {
            return (false, "La palabra debe tener al menos 3 letras", 0)
        }
        
        guard canFormWord(cleaned, from: availableLetters) else {
            return (false, "No puedes formar esta palabra con las letras disponibles", 0)
        }
        
        guard dictionaryManager.isValidWord(cleaned) else {
            return (false, "Esta palabra no está en el diccionario", 0)
        }
        
        let score = calculateScore(for: cleaned)
        return (true, "¡Palabra válida!", score)
    }
    
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
```

## 8. Gradient Backgrounds

```swift
struct GameView: View {
    var body: some View {
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
            
            // Content
            VStack {
                // Your game UI here
            }
        }
    }
}
```

## 9. Custom Button Styles

```swift
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
                    .background(Circle().fill(color.opacity(0.3)))
                
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

// Usage:
GameModeButton(
    title: "Juego de Números",
    subtitle: "Alcanza el número objetivo",
    icon: "number.square.fill",
    color: .orange
) {
    showNumberGame = true
}
```

## 10. Score Calculation

```swift
private func calculateScore(for word: String) -> Int {
    let length = word.count
    
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
```

## 11. Random Number Generation

```swift
private func generateNumbers(for difficulty: DifficultyLevel) {
    var numbers: [Int] = []
    
    let largeNumbers = [25, 50, 75, 100]
    let smallNumbers = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10]
    
    let largeCount: Int
    switch difficulty {
    case .beginner:
        largeCount = 1
    case .intermediate:
        largeCount = 2
    case .professional:
        largeCount = Int.random(in: 2...3)
    }
    
    // Select random large numbers
    var availableLarge = largeNumbers.shuffled()
    for _ in 0..<largeCount {
        if let number = availableLarge.popLast() {
            numbers.append(number)
        }
    }
    
    // Fill with small numbers
    let smallCount = 6 - largeCount
    var availableSmall = smallNumbers.shuffled()
    for _ in 0..<smallCount {
        if let number = availableSmall.popLast() {
            numbers.append(number)
        }
    }
    
    availableNumbers = numbers.shuffled()
}
```

## 12. Letter Generation

```swift
private func generateLetters(for difficulty: DifficultyLevel) {
    var letters: [Character] = []
    
    let vowels: [Character] = ["A", "E", "I", "O", "U"]
    let consonants: [Character] = [
        "B", "C", "D", "F", "G", "H", "J", "K", "L", "M",
        "N", "Ñ", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"
    ]
    
    let vowelCount: Int
    switch difficulty {
    case .beginner:
        vowelCount = 4
    case .intermediate:
        vowelCount = 3
    case .professional:
        vowelCount = Int.random(in: 2...3)
    }
    
    // Select random vowels
    for _ in 0..<vowelCount {
        if let vowel = vowels.randomElement() {
            letters.append(vowel)
        }
    }
    
    // Fill with consonants
    let consonantCount = 9 - vowelCount
    for _ in 0..<consonantCount {
        if let consonant = consonants.randomElement() {
            letters.append(consonant)
        }
    }
    
    availableLetters = letters.shuffled()
}
```

## 13. SwiftUI Previews

```swift
#Preview("Home View") {
    HomeView()
}

#Preview("Number Game - Beginner") {
    NavigationStack {
        NumberGameView(difficulty: .beginner)
    }
}

#Preview("Results - Success") {
    NavigationStack {
        ResultsView(
            gameType: "Números",
            playerAnswer: "50 + 25 × 2",
            isCorrect: true,
            message: "¡Perfecto! Resultado exacto: 100"
        )
    }
}
```

## 14. Formatting Time

```swift
private func formatTime(_ seconds: Int) -> String {
    let mins = seconds / 60
    let secs = seconds % 60
    return String(format: "%d:%02d", mins, secs)
}

// Usage:
Text(formatTime(gameModel.timeRemaining))
    .font(.title3)
    .fontWeight(.bold)
    .foregroundColor(timeRemaining <= 10 ? .red : .primary)
```

## 15. Conditional Styling

```swift
.foregroundColor(timeRemaining <= 10 ? .red : .blue)
.shadow(color: .black.opacity(isSelected ? 0.3 : 0.1), radius: isSelected ? 8 : 4)
.background(
    RoundedRectangle(cornerRadius: 15)
        .fill(isSelected ? Color.white : Color.white.opacity(0.9))
)
```

## Best Practices Demonstrated

1. **Separation of Concerns**: Models, Views, and Game Engines are separate
2. **Reusable Components**: `NumberTile`, `LetterTile`, `TimerView` can be reused
3. **Type Safety**: Strong typing with enums and structs
4. **State Management**: Proper use of `@Published`, `@StateObject`, `@State`
5. **Error Handling**: Validation returns descriptive error messages
6. **Performance**: Set for O(1) lookups, singleton for dictionary
7. **Clean Code**: Descriptive names, logical organization
8. **SwiftUI Patterns**: Proper use of modifiers, gradients, navigation

---

These code samples demonstrate the core patterns and techniques used throughout the application. They can serve as templates for similar iOS game development projects.
