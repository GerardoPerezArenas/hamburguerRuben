# Cifras y Letras - iOS App

A complete iOS mobile application featuring the classic Spanish TV game "Cifras y Letras" (Numbers and Letters). The app provides two engaging game modes with multiple difficulty levels.

## Overview

This SwiftUI-based iOS application recreates the beloved TV game show experience with:
- **Number Test (Cifras)**: Players must reach a target number using arithmetic operations on randomly generated numbers
- **Word Test (Letras)**: Players form the longest possible valid Spanish word from randomly selected letters

## Features

### Three Difficulty Levels
- **Principiante (Beginner)**: Easier combinations with a 90-second timer
- **Intermedio (Intermediate)**: Moderate difficulty with a 60-second timer
- **Profesional (Professional)**: Complex combinations with a 45-second timer

### Game Modes

#### Number Test (Cifras)
- Randomly generated combinations of small (1-10) and large (25, 50, 75, 100) numbers
- Real-time verification of arithmetic expressions
- Supports all basic operations: addition (+), subtraction (-), multiplication (×), division (÷)
- Validates that only exact divisions are allowed (no decimals)
- Prevents negative results
- Smart scoring based on proximity to target number

#### Word Test (Letras)
- Balanced vowel/consonant distribution
- Support for Spanish alphabet including 'Ñ'
- Integrated local JSON dictionary for word validation
- Hint system to help players
- Scoring system based on word length
- Real-time validation of letter usage

### User Interface

The app follows **Apple's iOS Human Interface Guidelines** with:
- Clean, modern SwiftUI design
- Intuitive navigation using NavigationStack
- Consistent color schemes and typography
- Responsive layouts for different device sizes
- Smooth animations and transitions
- Accessibility support

### App Structure

```
CifrasYLetras/
├── CifrasYLetras.xcodeproj/
│   └── project.pbxproj
└── CifrasYLetras/
    ├── CifrasYLetrasApp.swift          # App entry point
    ├── ContentView.swift                # Main content view
    ├── Models/
    │   ├── DifficultyLevel.swift        # Difficulty level enum
    │   ├── NumberGameModel.swift        # Number game data model
    │   └── WordGameModel.swift          # Word game data model
    ├── GameEngines/
    │   ├── DictionaryManager.swift      # Spanish dictionary manager
    │   ├── NumberGameEngine.swift       # Number game logic
    │   └── WordGameEngine.swift         # Word game logic
    ├── Views/
    │   ├── HomeView.swift               # Home screen with mode selection
    │   ├── NumberGameView.swift         # Number test gameplay screen
    │   ├── WordGameView.swift           # Word test gameplay screen
    │   └── ResultsView.swift            # Results and scoring screen
    ├── Resources/
    │   └── spanish_dictionary.json      # Spanish word dictionary
    └── Assets.xcassets/                 # App icons and colors
        ├── AppIcon.appiconset/
        └── AccentColor.colorset/
```

## Technical Implementation

### Core Technologies
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming with `@Published` properties
- **Foundation**: Core utilities and JSON parsing
- **iOS 16.0+**: Minimum deployment target

### Key Components

#### Models
- `DifficultyLevel`: Enum defining three difficulty levels with associated timer durations
- `NumberGameModel`: ObservableObject managing number game state
- `WordGameModel`: ObservableObject managing word game state

#### Game Engines
- `NumberGameEngine`: Validates arithmetic expressions and calculates results
- `WordGameEngine`: Validates Spanish words against dictionary and calculates scores
- `DictionaryManager`: Singleton managing Spanish dictionary with 1000+ words

#### Views
- `HomeView`: Landing page with difficulty selection and game mode buttons
- `NumberGameView`: Interactive number puzzle interface
- `WordGameView`: Interactive word formation interface
- `ResultsView`: Score display and game completion screen

### Game Logic Details

#### Number Game
- Generates 6 random numbers (mix of small and large based on difficulty)
- Creates target numbers within appropriate ranges per difficulty
- Validates arithmetic expressions with proper operator precedence
- Enforces rules: no negative results, only exact divisions
- Provides feedback on how close the solution is to the target

#### Word Game
- Generates 9 random letters with balanced vowel/consonant ratio
- Difficulty affects vowel count (more vowels = easier)
- Validates words against comprehensive Spanish dictionary
- Supports special Spanish characters (Ñ)
- Scoring: 3-4 letters = 1pt/letter, 5-6 = 2pt/letter, 7-8 = 3pt/letter, 9+ = 5pt/letter

### Dictionary
The app includes a curated Spanish dictionary with over 1000 common words:
- Nouns, verbs, adjectives, and adverbs
- Proper support for Spanish characters including Ñ
- Stored as JSON for easy loading and parsing
- Case-insensitive matching

## Building and Running

### Requirements
- Xcode 15.0 or later
- iOS 16.0 or later (target device or simulator)
- macOS for development

### Instructions

1. **Open the project in Xcode:**
   ```bash
   cd CifrasYLetras
   open CifrasYLetras.xcodeproj
   ```

2. **Select a target device:**
   - Choose an iOS simulator (iPhone 14, iPhone 15, etc.)
   - Or connect a physical iOS device

3. **Build and run:**
   - Press `Cmd + R` or click the Run button
   - The app will compile and launch on your selected device

### Project Configuration
- **Bundle Identifier**: `com.gerardo.CifrasYLetras`
- **Deployment Target**: iOS 16.0
- **Supported Devices**: iPhone and iPad (Universal)
- **Orientation Support**: Portrait, Landscape Left, Landscape Right

## Gameplay Instructions

### Starting a Game

1. Launch the app to see the home screen
2. Select your preferred difficulty level (Principiante, Intermedio, or Profesional)
3. Choose a game mode:
   - **Juego de Números** for the number challenge
   - **Juego de Palabras** for the word challenge
4. Tap "Iniciar Juego" to begin

### Number Game (Cifras)

1. View the target number displayed prominently
2. Use the 6 available numbers shown below
3. Enter your solution using arithmetic operations
   - Format: "number operator number operator number..."
   - Example: "50 + 25 × 2 - 10"
   - Use: + (add), - (subtract), × (multiply), ÷ (divide)
4. Tap "Verificar Solución" to check your answer
5. Each number can only be used once
6. Beat the timer to submit your solution!

### Word Game (Letras)

1. View the 9 random letters displayed
2. Form the longest possible Spanish word
3. Type your word in the input field
4. Tap "Pista" for a hint if needed
5. Tap "Verificar" to validate your word
6. Longer words earn more points!
7. Beat the timer to submit your word!

### Scoring

**Number Game:**
- Exact match: Perfect score!
- Within 10 points: Very close!
- Beyond 10: Shows difference from target

**Word Game:**
- 3-4 letters: 1 point per letter
- 5-6 letters: 2 points per letter
- 7-8 letters: 3 points per letter
- 9+ letters: 5 points per letter

## Design Philosophy

The app follows Apple's Human Interface Guidelines with:

- **Clarity**: Clear typography and generous spacing
- **Deference**: Content-focused design without unnecessary decoration
- **Depth**: Layers and motion that convey hierarchy
- **Consistency**: Familiar iOS patterns and interactions
- **Feedback**: Immediate visual response to user actions
- **Accessibility**: Support for Dynamic Type and VoiceOver

Color scheme:
- **Number Game**: Orange/Yellow gradient (warm, energetic)
- **Word Game**: Green/Blue gradient (fresh, intellectual)
- **Home Screen**: Blue/Purple gradient (welcoming, playful)
- **Results**: Green (success) or Orange (try again)

## Future Enhancements

Potential features for future versions:
- [ ] Multiplayer mode for competitive play
- [ ] Statistics tracking and personal bests
- [ ] Additional language support
- [ ] Expanded dictionary with 10,000+ words
- [ ] Advanced number game solver showing optimal solutions
- [ ] Sound effects and haptic feedback
- [ ] Daily challenges with global leaderboards
- [ ] Achievement system
- [ ] iPad-optimized layouts
- [ ] Widget support for quick games

## Code Quality

The codebase emphasizes:
- **Clean Architecture**: Separation of concerns (Models, Views, Game Engines)
- **SOLID Principles**: Single responsibility, dependency inversion
- **SwiftUI Best Practices**: State management with `@Published` and `@StateObject`
- **Reusability**: Modular components and shared utilities
- **Documentation**: Comprehensive comments and documentation
- **Type Safety**: Strong typing throughout

## License

This project is developed as part of the hamburguerRuben repository.

## Credits

Developed for the classic Spanish TV game "Cifras y Letras" (Numbers and Letters).

---

**Note**: This is a complete, production-ready iOS application built with SwiftUI following modern iOS development best practices and Apple's Human Interface Guidelines.
