# Arquitectura de la Aplicación

## Patrón MVVM en Cifras y Letras

Esta aplicación sigue el patrón **Model-View-ViewModel (MVVM)** para separar la lógica de negocio de la interfaz de usuario.

## 📊 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────┐
│                         Views                            │
│  (SwiftUI - Interfaz de Usuario)                        │
│                                                          │
│  HomeView, CifrasGameView, LetrasGameView, etc.         │
└────────────────┬────────────────────────────────────────┘
                 │ @Published properties
                 │ User actions
                 ▼
┌─────────────────────────────────────────────────────────┐
│                      ViewModels                          │
│  (Lógica de Presentación - ObservableObject)           │
│                                                          │
│  HomeViewModel, CifrasViewModel, LetrasViewModel, etc.  │
└────────────────┬────────────────────────────────────────┘
                 │ Calls to services
                 │ Updates models
                 ▼
┌─────────────────────────────────────────────────────────┐
│                       Services                           │
│  (Lógica de Negocio)                                    │
│                                                          │
│  CifrasGenerator, DictionaryService, StatsService, etc. │
└────────────────┬────────────────────────────────────────┘
                 │ Uses & modifies
                 ▼
┌─────────────────────────────────────────────────────────┐
│                        Models                            │
│  (Datos - Structs & Enums)                              │
│                                                          │
│  GameMode, DifficultyLevel, CifrasGameState, etc.       │
└─────────────────────────────────────────────────────────┘
```

## 🏗 Capas de la Aplicación

### 1. Models (Modelos de Datos)

**Responsabilidad**: Definir la estructura de datos de la aplicación

**Características**:
- Structs inmutables (value types)
- Conforman a Codable para persistencia
- Sin lógica de negocio (solo datos)
- Sin dependencias de otras capas

**Archivos**:
```swift
GameMode.swift          // Enum: cifras, letras
DifficultyLevel.swift   // Enum: principiante, intermedio, profesional
CifrasGameState.swift   // Estado del juego de números
LetrasGameState.swift   // Estado del juego de letras
Score.swift             // Puntuación individual
UserStats.swift         // Estadísticas acumuladas
```

**Ejemplo**:
```swift
struct CifrasGameState: Codable {
    let difficulty: DifficultyLevel
    let availableNumbers: [Int]
    let targetNumber: Int
    var userExpression: String
    var timeRemaining: Int
    var isComplete: Bool
    var score: Int
}
```

### 2. Views (Vistas)

**Responsabilidad**: Presentar la interfaz de usuario

**Características**:
- SwiftUI views
- Declaran la UI de forma declarativa
- Observan ViewModels con @StateObject/@ObservedObject
- No contienen lógica de negocio
- Reaccionan a cambios en ViewModels

**Archivos principales**:
```swift
HomeView.swift              // Pantalla principal
ModeSelectionView.swift     // Selector de modo
DifficultySelectionView.swift // Selector de dificultad
CifrasGameView.swift        // Juego de números
LetrasGameView.swift        // Juego de letras
ResultsView.swift           // Pantalla de resultados
StatsView.swift             // Estadísticas
SettingsView.swift          // Configuración
```

**Componentes reutilizables**:
```swift
PrimaryButton.swift         // Botón principal
TimerView.swift            // Cronómetro
LetterTileView.swift       // Ficha de letra
NumberTileView.swift       // Ficha de número
```

**Ejemplo**:
```swift
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Cifras y Letras")
                PrimaryButton(title: "Jugar") {
                    viewModel.startQuickGame()
                }
            }
        }
    }
}
```

### 3. ViewModels

**Responsabilidad**: Lógica de presentación y coordinación

**Características**:
- Clases que conforman ObservableObject
- Exponen @Published properties para que Views observen
- Coordinan entre Services y Models
- Manejan el estado de la UI
- Transforman datos del modelo para presentación

**Archivos**:
```swift
HomeViewModel.swift         // Lógica de pantalla principal
CifrasViewModel.swift       // Lógica del juego de números
LetrasViewModel.swift       // Lógica del juego de letras
ResultsViewModel.swift      // Lógica de resultados
SettingsViewModel.swift     // Lógica de configuración
```

**Ejemplo**:
```swift
class CifrasViewModel: ObservableObject {
    @Published var gameState: CifrasGameState
    @Published var timeRemaining: Int
    @Published var isGameActive = true
    
    private let generator: CifrasGenerator
    private let evaluator: ExpressionEvaluator
    private var timer: Timer?
    
    init(difficulty: DifficultyLevel) {
        // Inicialización usando servicios
        self.generator = CifrasGenerator()
        self.evaluator = ExpressionEvaluator()
        // ... generar estado inicial
    }
    
    func validateSolution() {
        // Coordinar validación usando servicios
        let result = try? evaluator.evaluate(gameState.userExpression)
        // ... actualizar estado
    }
}
```

### 4. Services (Servicios)

**Responsabilidad**: Lógica de negocio y operaciones complejas

**Características**:
- Clases o structs sin estado (stateless cuando es posible)
- Encapsulan operaciones complejas
- Pueden ser compartidos entre ViewModels
- Manejan persistencia, cálculos, generación, etc.

**Archivos**:
```swift
CifrasGenerator.swift       // Genera números y objetivos
LetrasGenerator.swift       // Genera letras con distribución
ExpressionEvaluator.swift   // Evalúa expresiones matemáticas
DictionaryService.swift     // Valida palabras
StatsService.swift          // Gestiona estadísticas (UserDefaults)
DifficultyService.swift     // Gestiona configuración de dificultad
```

**Ejemplo**:
```swift
class CifrasGenerator {
    func generateNumbers(for difficulty: DifficultyLevel) -> [Int] {
        // Lógica compleja de generación
        var numbers: [Int] = []
        // ...
        return numbers
    }
    
    func generateTarget(for difficulty: DifficultyLevel) -> Int {
        // Lógica de generación de objetivo
        let range = difficulty.cifrasTargetRange
        return Int.random(in: range)
    }
}
```

## 🔄 Flujo de Datos

### Flujo típico de una acción del usuario:

```
1. User taps button in View
   │
   ▼
2. View calls method on ViewModel
   │
   ▼
3. ViewModel calls Service(s)
   │
   ▼
4. Service performs business logic
   │
   ▼
5. Service returns result to ViewModel
   │
   ▼
6. ViewModel updates @Published properties
   │
   ▼
7. View automatically re-renders (SwiftUI)
```

### Ejemplo concreto: Validar solución en Cifras

```swift
// 1. Usuario toca botón "Validar"
Button("Validar solución") {
    viewModel.validateSolution()  // 2. View llama ViewModel
}

// 3-5. ViewModel coordina servicios
func validateSolution() {
    // Validar números
    guard evaluator.validate(expression: currentExpression, 
                            withNumbers: gameState.availableNumbers) 
    else { return }
    
    // Evaluar expresión
    let result = try evaluator.evaluate(currentExpression)
    
    // Calcular puntuación
    gameState.calculateScore(result: result)
    
    // Guardar estadísticas
    let score = Score(gameMode: .cifras, 
                     difficulty: gameState.difficulty, 
                     points: gameState.score)
    statsService.addScore(score)
    
    // 6. Actualizar estado publicado
    showResults = true  // @Published property
}

// 7. SwiftUI re-renderiza automáticamente
.sheet(isPresented: $viewModel.showResults) {
    ResultsView(...)
}
```

## 🎯 Principios de Diseño

### 1. Separation of Concerns (SoC)

Cada capa tiene una responsabilidad única y bien definida:

```swift
// ❌ MAL: View con lógica de negocio
struct GameView: View {
    var body: some View {
        Button("Validar") {
            let result = Int(expression) ?? 0  // Lógica en View
            if result == target {
                score = 10  // Estado en View
            }
        }
    }
}

// ✅ BIEN: View delega a ViewModel
struct GameView: View {
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        Button("Validar") {
            viewModel.validateSolution()  // Delega
        }
    }
}
```

### 2. Dependency Injection

Los ViewModels reciben servicios por inyección:

```swift
class CifrasViewModel: ObservableObject {
    private let generator: CifrasGenerator
    private let evaluator: ExpressionEvaluator
    
    // Permite testing con mocks
    init(difficulty: DifficultyLevel,
         generator: CifrasGenerator = CifrasGenerator(),
         evaluator: ExpressionEvaluator = ExpressionEvaluator()) {
        self.generator = generator
        self.evaluator = evaluator
        // ...
    }
}
```

### 3. Single Source of Truth

El estado vive en un solo lugar:

```swift
// ViewModel es la fuente de verdad
class GameViewModel: ObservableObject {
    @Published var gameState: GameState  // Estado principal
    
    // Views observan este estado
    // No mantienen su propio estado duplicado
}
```

### 4. Immutability When Possible

Preferir structs inmutables:

```swift
// Models son structs
struct Score: Codable {
    let id: UUID
    let gameMode: GameMode
    let points: Int
    let date: Date
    // Inmutables después de creación
}
```

## 🧪 Testing

### Unit Tests para Services

```swift
class CifrasGeneratorTests: XCTestCase {
    var generator: CifrasGenerator!
    
    override func setUp() {
        generator = CifrasGenerator()
    }
    
    func testGeneratesCorrectNumberCount() {
        let numbers = generator.generateNumbers(for: .principiante)
        XCTAssertEqual(numbers.count, 6)
    }
    
    func testTargetInRange() {
        let target = generator.generateTarget(for: .intermedio)
        XCTAssertTrue((300...700).contains(target))
    }
}
```

### Unit Tests para ViewModels

```swift
class CifrasViewModelTests: XCTestCase {
    var viewModel: CifrasViewModel!
    var mockGenerator: MockCifrasGenerator!
    
    override func setUp() {
        mockGenerator = MockCifrasGenerator()
        viewModel = CifrasViewModel(
            difficulty: .intermedio,
            generator: mockGenerator
        )
    }
    
    func testValidateCorrectExpression() {
        viewModel.currentExpression = "25 + 50"
        viewModel.validateSolution()
        
        XCTAssertGreaterThan(viewModel.gameState.score, 0)
    }
}
```

## 📦 Persistencia

### UserDefaults para datos simples

```swift
class StatsService {
    private let userDefaults = UserDefaults.standard
    private let statsKey = "userStats"
    
    func saveStats(_ stats: UserStats) {
        let data = try? JSONEncoder().encode(stats)
        userDefaults.set(data, forKey: statsKey)
    }
    
    func loadStats() -> UserStats {
        guard let data = userDefaults.data(forKey: statsKey),
              let stats = try? JSONDecoder().decode(UserStats.self, from: data)
        else { return UserStats() }
        return stats
    }
}
```

### Posible migración a Core Data

Para apps más complejas, se podría migrar a Core Data:

```swift
// Futuro: Core Data para sincronización iCloud
class CoreDataStatsService {
    private let container: NSPersistentContainer
    
    // Similar interface, diferente implementación
    func saveStats(_ stats: UserStats) { ... }
    func loadStats() -> UserStats { ... }
}
```

## 🔐 Seguridad y Validación

### Validación en múltiples capas

```swift
// 1. View: Validación UI básica
Button("Validar") {
    guard !viewModel.currentExpression.isEmpty else { return }
    viewModel.validateSolution()
}

// 2. ViewModel: Validación de estado
func validateSolution() {
    guard isGameActive else { return }
    // ...
}

// 3. Service: Validación de lógica de negocio
func validate(expression: String, withNumbers: [Int]) -> Bool {
    let numbers = extractNumbers(from: expression)
    // Verificar que números estén disponibles
    // ...
}
```

## 🚀 Optimizaciones

### Lazy Loading

```swift
// Diccionario cargado solo cuando se necesita
class DictionaryService {
    private lazy var dictionary: Set<String> = {
        loadDictionary()
    }()
}
```

### Debouncing

```swift
// Para búsqueda/validación en tiempo real
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.performSearch(text)
            }
            .store(in: &cancellables)
    }
}
```

## 📊 Diagrama de Flujo Completo

```
App Launch
    │
    ├─→ HomeView loads
    │       │
    │       ├─→ HomeViewModel init
    │       │       │
    │       │       ├─→ DifficultyService.getSelectedDifficulty()
    │       │       └─→ StatsService.loadStats()
    │       │
    │       └─→ Display UI
    │
User Action: "Jugar rápido"
    │
    ├─→ HomeViewModel.startQuickGame()
    │       │
    │       └─→ Show GameView
    │               │
    │               └─→ CifrasGameView init
    │                       │
    │                       ├─→ CifrasViewModel init
    │                       │       │
    │                       │       ├─→ CifrasGenerator.generateNumbers()
    │                       │       ├─→ CifrasGenerator.generateTarget()
    │                       │       └─→ Start Timer
    │                       │
    │                       └─→ Display Game UI
    │
User Action: "Validar solución"
    │
    ├─→ CifrasViewModel.validateSolution()
    │       │
    │       ├─→ ExpressionEvaluator.validate()
    │       ├─→ ExpressionEvaluator.evaluate()
    │       ├─→ Calculate score
    │       ├─→ StatsService.addScore()
    │       └─→ Show ResultsView
    │
    └─→ ResultsView
            │
            ├─→ Display score
            ├─→ Show suggestions
            └─→ User chooses next action
```

---

Esta arquitectura permite:
- ✅ Código mantenible y testeable
- ✅ Separación clara de responsabilidades
- ✅ Fácil extensión de funcionalidades
- ✅ Reutilización de componentes
- ✅ Testing unitario efectivo
