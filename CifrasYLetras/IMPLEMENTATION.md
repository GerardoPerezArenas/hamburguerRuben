# Implementation Guide - Cifras y Letras iOS App

## Project Overview

This document provides a comprehensive guide to the implementation of the "Cifras y Letras" iOS application. The app is a complete recreation of the classic Spanish TV game show, built with modern SwiftUI and following Apple's Human Interface Guidelines.

## Architecture

### Design Pattern: MVVM (Model-View-ViewModel)

The application follows the MVVM architecture pattern:

- **Models**: Pure data structures representing game state
- **ViewModels**: Business logic and state management (integrated into Models using `ObservableObject`)
- **Views**: SwiftUI views for UI presentation
- **Game Engines**: Separate business logic for game rules and validation

### File Organization

```
CifrasYLetras/
├── Models/              # Data models and game state
├── GameEngines/         # Game logic and validation
├── Views/               # SwiftUI UI components
└── Resources/           # Assets like dictionary JSON
```

## Implementation Details

### 1. Difficulty System

**File**: `Models/DifficultyLevel.swift`

The difficulty system is implemented as an enum with associated values:

```swift
enum DifficultyLevel: String, CaseIterable, Identifiable {
    case beginner = "Principiante"
    case intermediate = "Intermedio"
    case professional = "Profesional"
}
```

**Key Features**:
- Timer durations: 90s (beginner), 60s (intermediate), 45s (professional)
- Affects number complexity and letter distribution
- Provides localized descriptions and icons

### 2. Number Game Implementation

**Files**: 
- `Models/NumberGameModel.swift` (State management)
- `GameEngines/NumberGameEngine.swift` (Validation logic)

**Number Generation Algorithm**:
```
For Beginner:
  - 1 large number (25, 50, 75, 100)
  - 5 small numbers (1-10, duplicates allowed)
  - Target: 100-500

For Intermediate:
  - 2 large numbers
  - 4 small numbers
  - Target: 200-700

For Professional:
  - 2-3 large numbers
  - 3-4 small numbers
  - Target: 300-999
```

**Arithmetic Validation Rules**:
1. Each number can only be used once
2. Only exact divisions allowed (no decimals)
3. No negative results allowed
4. Standard operator precedence applies
5. Expression format: "number operator number operator number..."

**Expression Parser**:
The `NumberGameEngine` implements a simple expression evaluator that:
- Parses space-separated tokens
- Validates number availability
- Applies operations sequentially
- Enforces arithmetic constraints

### 3. Word Game Implementation

**Files**:
- `Models/WordGameModel.swift` (State management)
- `GameEngines/WordGameEngine.swift` (Validation logic)
- `GameEngines/DictionaryManager.swift` (Dictionary management)

**Letter Generation Algorithm**:
```
Total letters: Always 9

Vowel distribution by difficulty:
  - Beginner: 4 vowels, 5 consonants
  - Intermediate: 3 vowels, 6 consonants
  - Professional: 2-3 vowels, 6-7 consonants

Available vowels: A, E, I, O, U
Available consonants: B, C, D, F, G, H, J, K, L, M, N, Ñ, P, Q, R, S, T, V, W, X, Y, Z
```

**Word Validation Process**:
1. Check minimum length (3 letters)
2. Verify all letters are available
3. Ensure each letter is used only once
4. Look up word in Spanish dictionary
5. Calculate score based on word length

**Scoring System**:
```
3-4 letters:  length × 1 point
5-6 letters:  length × 2 points
7-8 letters:  length × 3 points
9+ letters:   length × 5 points
```

### 4. Dictionary System

**File**: `GameEngines/DictionaryManager.swift`

**Implementation**:
- Singleton pattern for efficient memory usage
- Loads dictionary once at app launch
- Uses `Set<String>` for O(1) lookup performance
- Case-insensitive matching
- Supports Spanish characters (Ñ, accented vowels)

**Dictionary Content**:
- 1000+ common Spanish words
- Nouns, verbs, adjectives, adverbs
- Properly supports Ñ and accented characters
- Stored in JSON format for easy maintenance

### 5. User Interface

#### Home Screen (`Views/HomeView.swift`)

**Components**:
- Gradient background (blue to purple)
- App title and subtitle
- Difficulty selector (3 buttons)
- Game mode buttons (Numbers and Words)

**Navigation**:
Uses SwiftUI's `NavigationStack` with `navigationDestination`:
```swift
.navigationDestination(isPresented: $showNumberGame) {
    NumberGameView(difficulty: selectedDifficulty)
}
```

#### Number Game Screen (`Views/NumberGameView.swift`)

**Layout**:
1. Header with title and timer
2. Target number display (large, prominent)
3. Available numbers grid (6 tiles)
4. Solution input field
5. Verify button
6. Validation result display

**UI Components**:
- `NumberTile`: Reusable component for displaying numbers
- `TimerView`: Countdown timer with color coding (red when < 10s)
- Form with arithmetic operator hints

**State Management**:
- Uses `@StateObject` for `NumberGameModel`
- Timer updates via `Timer.scheduledTimer`
- Automatic navigation to results on timeout or success

#### Word Game Screen (`Views/WordGameView.swift`)

**Layout**:
1. Header with title and timer
2. Available letters display (9 tiles)
3. Word input field with auto-capitalization
4. Hint and Verify buttons
5. Hint display area
6. Validation result display
7. Game instructions

**UI Components**:
- `LetterTile`: Reusable component for displaying letters
- Hint system with random word suggestion
- Real-time input validation

**Features**:
- Hint button provides a 4-6 letter word suggestion
- Auto-capitalization for word input
- Immediate feedback on validation

#### Results Screen (`Views/ResultsView.swift`)

**Layout**:
1. Success/failure icon (checkmark or X)
2. Result message
3. Player's answer display
4. Score display (for word game)
5. Return to home button

**Visual Feedback**:
- Green gradient for success
- Orange/red gradient for partial success or failure
- Large, animated icons
- Prominent score display with star icons

### 6. Game Flow

**Number Game Flow**:
```
1. User selects difficulty on home screen
2. User taps "Juego de Números"
3. Game screen loads but game is inactive
4. User taps "Iniciar Juego"
5. Numbers and target generated
6. Timer starts (90s/60s/45s)
7. User enters arithmetic expression
8. User taps "Verificar Solución"
9. Expression validated and result calculated
10. Feedback displayed
11. On success or timeout, navigate to results
12. Results screen shows score and message
13. User returns to home
```

**Word Game Flow**:
```
1. User selects difficulty on home screen
2. User taps "Juego de Palabras"
3. Game screen loads but game is inactive
4. User taps "Iniciar Juego"
5. Letters generated
6. Timer starts (90s/60s/45s)
7. User types word (optional: request hint)
8. User taps "Verificar"
9. Word validated against dictionary
10. Letters verified as available
11. Score calculated
12. Feedback displayed
13. On success or timeout, navigate to results
14. Results screen shows score and message
15. User returns to home
```

### 7. Timer Implementation

**Mechanism**:
```swift
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
    gameModel.updateTimer()
    
    if gameModel.timeRemaining == 0 {
        timer?.invalidate()
        showResults = true
    }
}
```

**Features**:
- Updates every second
- Displayed in MM:SS format
- Visual warning when < 10 seconds (red color)
- Auto-ends game at 0
- Properly invalidated to prevent memory leaks

### 8. State Management

**Published Properties**:
All game models use `@Published` for reactive updates:

```swift
class NumberGameModel: ObservableObject {
    @Published var availableNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var isGameActive: Bool = false
    // ...
}
```

**View Observation**:
Views use `@StateObject` to observe model changes:

```swift
@StateObject private var gameModel = NumberGameModel()
```

### 9. Accessibility

**Implementation**:
- Semantic labels for all interactive elements
- Support for Dynamic Type
- High contrast colors
- Clear visual hierarchy
- Large touch targets (minimum 44x44 points)

### 10. Performance Considerations

**Optimizations**:
1. **Dictionary Loading**: Loaded once at app start, cached in memory
2. **Set for Lookup**: O(1) word validation using `Set<String>`
3. **Lazy Loading**: SwiftUI views load on demand
4. **Timer Management**: Properly invalidated to prevent leaks
5. **Memory Efficiency**: Singleton pattern for DictionaryManager

**Resource Usage**:
- Dictionary: ~15KB JSON file
- Memory footprint: < 10MB typical
- CPU usage: Minimal (timer updates, validation only)

## Code Quality

### Documentation
- Every file has a header comment
- Complex functions have inline documentation
- Public APIs documented with Swift-style comments

### Code Style
- Consistent naming conventions (camelCase, PascalCase)
- Clear variable names
- Logical file organization
- Separation of concerns

### SwiftUI Best Practices
- Extracted reusable components
- Proper state management
- Minimal view complexity
- Preview support for all views

## Testing Recommendations

### Manual Testing Checklist

**Number Game**:
- [ ] Verify numbers generate correctly for each difficulty
- [ ] Test arithmetic validation with various expressions
- [ ] Verify division by zero prevention
- [ ] Test negative result prevention
- [ ] Verify each number can only be used once
- [ ] Test timer functionality
- [ ] Verify navigation to results

**Word Game**:
- [ ] Verify letter distribution for each difficulty
- [ ] Test word validation with valid Spanish words
- [ ] Test rejection of invalid words
- [ ] Verify letter usage constraints
- [ ] Test hint system
- [ ] Test score calculation
- [ ] Test timer functionality

**UI/UX**:
- [ ] Test on different iPhone sizes
- [ ] Test on iPad
- [ ] Test in portrait and landscape
- [ ] Verify all buttons respond to taps
- [ ] Check text readability
- [ ] Verify color contrast

### Unit Testing (Future Enhancement)

Recommended unit tests:
```swift
// NumberGameEngine tests
func testValidArithmeticExpression()
func testInvalidDivision()
func testNegativeResultPrevention()
func testNumberReusePrevention()

// WordGameEngine tests
func testValidWordRecognition()
func testInvalidWordRejection()
func testLetterUsageValidation()
func testScoreCalculation()

// DictionaryManager tests
func testDictionaryLoading()
func testWordLookup()
func testCaseInsensitivity()
```

## Deployment

### Build Configuration

**Debug**:
- Optimization level: None (-Onone)
- Debug symbols included
- Testability enabled

**Release**:
- Optimization level: Whole module (-O)
- Debug symbols stripped
- Code signing required

### App Store Submission Checklist

- [ ] Create app icons (all required sizes)
- [ ] Add app description and keywords
- [ ] Create screenshots for all device sizes
- [ ] Set privacy policy (if collecting data)
- [ ] Configure app capabilities
- [ ] Test on physical devices
- [ ] Complete App Store metadata
- [ ] Submit for review

## Maintenance

### Adding New Words to Dictionary

1. Open `Resources/spanish_dictionary.json`
2. Add words in uppercase format
3. Maintain alphabetical order (optional but recommended)
4. Ensure no duplicates
5. Test word validation

### Modifying Difficulty Levels

To adjust difficulty parameters:

1. Edit `Models/DifficultyLevel.swift`
2. Modify `timerDuration` property
3. Edit number generation logic in `NumberGameModel`
4. Edit letter generation logic in `WordGameModel`

### Adding New Features

Recommended approach:
1. Create new model/view files in appropriate directories
2. Follow existing naming conventions
3. Maintain separation of concerns
4. Update this documentation
5. Add appropriate tests

## Troubleshooting

### Common Issues

**Issue**: Dictionary not loading
- **Solution**: Verify `spanish_dictionary.json` is included in bundle resources

**Issue**: Timer not updating
- **Solution**: Ensure timer is properly scheduled on main thread

**Issue**: Navigation not working
- **Solution**: Verify `NavigationStack` wraps the entire view hierarchy

**Issue**: State not updating
- **Solution**: Ensure models use `@Published` and views use `@StateObject`

## Future Enhancements

### Planned Features

1. **Statistics Tracking**
   - Store game results in UserDefaults or Core Data
   - Display personal bests
   - Track win/loss ratios

2. **Multiplayer**
   - Local multiplayer (pass-and-play)
   - Online multiplayer using Game Center
   - Leaderboards

3. **Advanced Number Solver**
   - Implement complete solution finder
   - Show optimal solutions after game ends
   - Hint system for number game

4. **Expanded Dictionary**
   - Increase to 10,000+ words
   - Add difficulty-based word filtering
   - Include word definitions

5. **Sound and Haptics**
   - Background music
   - Sound effects for actions
   - Haptic feedback on interactions

6. **Achievements**
   - Perfect score achievements
   - Speed achievements
   - Consecutive win streaks

## Conclusion

This iOS application provides a complete, polished implementation of the "Cifras y Letras" game. The code is well-organized, follows iOS best practices, and provides a solid foundation for future enhancements. The modular architecture makes it easy to maintain and extend with new features.

For questions or contributions, please refer to the main README.md file.

---

**Last Updated**: November 2025  
**Version**: 1.0  
**Minimum iOS**: 16.0  
**Swift Version**: 5.0
