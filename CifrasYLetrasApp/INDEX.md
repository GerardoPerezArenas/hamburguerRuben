# Índice del Proyecto - Cifras y Letras iOS App

## 📁 Estructura Completa de Archivos

```
CifrasYLetrasApp/
│
├── README.md                          # Documentación principal
├── INSTALL.md                         # Guía de instalación
├── DESIGN.md                          # Especificaciones de diseño
├── ARCHITECTURE.md                    # Documentación de arquitectura
│
├── App/
│   └── CifrasYLetrasApp.swift        # Punto de entrada (@main)
│
├── Models/                            # Capa de datos
│   ├── GameMode.swift                # Enum: Cifras, Letras
│   ├── DifficultyLevel.swift         # Enum: Principiante, Intermedio, Profesional
│   ├── CifrasGameState.swift         # Estado del juego de números
│   ├── LetrasGameState.swift         # Estado del juego de letras
│   ├── Score.swift                   # Modelo de puntuación
│   └── UserStats.swift               # Estadísticas del usuario
│
├── ViewModels/                        # Capa de lógica de presentación
│   ├── HomeViewModel.swift           # VM para pantalla principal
│   ├── CifrasViewModel.swift         # VM para juego de números
│   ├── LetrasViewModel.swift         # VM para juego de letras
│   ├── ResultsViewModel.swift        # VM para resultados
│   └── SettingsViewModel.swift       # VM para configuración
│
├── Views/                             # Capa de interfaz de usuario
│   ├── HomeView.swift                # Pantalla principal
│   ├── ModeSelectionView.swift       # Selector de modo
│   ├── DifficultySelectionView.swift # Selector de dificultad
│   ├── GameView.swift                # Coordinador de juego
│   ├── CifrasGameView.swift          # Pantalla juego de números
│   ├── LetrasGameView.swift          # Pantalla juego de letras
│   ├── ResultsView.swift             # Pantalla de resultados
│   ├── StatsView.swift               # Estadísticas
│   ├── SettingsView.swift            # Configuración
│   │
│   └── Components/                   # Componentes reutilizables
│       ├── PrimaryButton.swift       # Botón principal
│       ├── TimerView.swift           # Cronómetro
│       ├── LetterTileView.swift      # Ficha de letra
│       └── NumberTileView.swift      # Ficha de número
│
├── Services/                          # Capa de lógica de negocio
│   ├── CifrasGenerator.swift         # Generador de números
│   ├── LetrasGenerator.swift         # Generador de letras
│   ├── ExpressionEvaluator.swift     # Evaluador de expresiones
│   ├── DictionaryService.swift       # Servicio de diccionario
│   ├── StatsService.swift            # Gestión de estadísticas
│   └── DifficultyService.swift       # Gestión de dificultad
│
├── Resources/                         # Recursos de la app
│   ├── dictionary_es.json            # Diccionario español (200+ palabras)
│   ├── Localizable.strings           # Textos localizados
│   ├── Strings.swift                 # Acceso tipado a strings
│   └── ASSETS_CONFIG.md              # Guía de configuración de assets
│
└── Tests/                             # Tests unitarios
    └── CifrasYLetrasAppTests.swift   # Suite de tests

```

## 📊 Métricas del Proyecto

### Estadísticas de Código

- **Total de archivos Swift**: 30+
- **Líneas de código**: ~5,000
- **Modelos**: 6 archivos
- **ViewModels**: 5 archivos
- **Views**: 12 archivos
- **Services**: 6 archivos
- **Tests**: 50+ casos de prueba

### Cobertura de Funcionalidades

#### ✅ Completamente Implementado

- [x] Arquitectura MVVM completa
- [x] Dos modos de juego (Cifras y Letras)
- [x] Tres niveles de dificultad
- [x] Sistema de cronómetro
- [x] Sistema de puntuación
- [x] Persistencia de estadísticas (UserDefaults)
- [x] Generador de números con lógica de dificultad
- [x] Generador de letras con distribución española
- [x] Evaluador de expresiones matemáticas
- [x] Validador de palabras con diccionario
- [x] Pantallas completas de UI
- [x] Componentes reutilizables
- [x] Diseño responsive
- [x] Soporte para modo claro/oscuro
- [x] Localización en español
- [x] Tests unitarios

## 📖 Guías de Documentación

### Para Desarrolladores

1. **[INSTALL.md](INSTALL.md)** - Comienza aquí
   - Requisitos del sistema
   - Instalación paso a paso
   - Ejecución y debugging
   - Solución de problemas

2. **[ARCHITECTURE.md](ARCHITECTURE.md)**
   - Patrón MVVM explicado
   - Flujo de datos
   - Principios de diseño
   - Ejemplos de testing

3. **[DESIGN.md](DESIGN.md)**
   - Guía de estilo visual
   - Paleta de colores
   - Tipografía
   - Componentes UI
   - Mockups de pantallas

4. **[README.md](README.md)**
   - Descripción general
   - Características
   - Sistema de puntuación
   - Futuras mejoras

### Para Diseñadores

- **[DESIGN.md](DESIGN.md)** - Guía completa de diseño visual
- **[Resources/ASSETS_CONFIG.md](Resources/ASSETS_CONFIG.md)** - Configuración de assets

## 🎯 Casos de Uso Principales

### 1. Jugar Partida de Cifras

```
Usuario → HomeView
  ↓ Tap "Jugar rápido"
  ↓ Si no hay modo seleccionado → ModeSelectionView
  ↓ Selecciona "Cifras"
  ↓ CifrasGameView se presenta
  ↓ Usuario construye expresión "25 + 50 × 7"
  ↓ Tap "Validar solución"
  ↓ CifrasViewModel evalúa expresión
  ↓ Calcula puntuación
  ↓ Guarda estadísticas
  ↓ ResultsView se presenta
```

### 2. Jugar Partida de Letras

```
Usuario → HomeView
  ↓ Tap "Elegir modo"
  ↓ ModeSelectionView
  ↓ Selecciona "Letras"
  ↓ LetrasGameView se presenta
  ↓ Usuario escribe "CASA"
  ↓ Tap "Validar palabra"
  ↓ LetrasViewModel valida con diccionario
  ↓ Palabra válida → +4 puntos
  ↓ Usuario puede continuar escribiendo palabras
  ↓ Tap "Finalizar juego"
  ↓ ResultsView se presenta
```

### 3. Cambiar Dificultad

```
Usuario → HomeView
  ↓ Tap "Ajustes"
  ↓ DifficultySelectionView
  ↓ Selecciona "Profesional"
  ↓ DifficultyService guarda preferencia
  ↓ Futuras partidas usan nuevo nivel
```

## 🔑 Componentes Clave

### Modelos

| Archivo | Propósito | Tipo |
|---------|-----------|------|
| GameMode | Define modos de juego | Enum |
| DifficultyLevel | Define niveles de dificultad | Enum |
| CifrasGameState | Estado de partida de números | Struct |
| LetrasGameState | Estado de partida de letras | Struct |
| Score | Puntuación individual | Struct |
| UserStats | Estadísticas acumuladas | Struct |

### Services

| Servicio | Responsabilidad |
|----------|----------------|
| CifrasGenerator | Generar números y objetivos |
| LetrasGenerator | Generar letras con distribución |
| ExpressionEvaluator | Evaluar expresiones matemáticas |
| DictionaryService | Validar palabras |
| StatsService | Persistir estadísticas |
| DifficultyService | Gestionar configuración |

### Views

| Vista | Descripción |
|-------|-------------|
| HomeView | Menú principal |
| ModeSelectionView | Elegir Cifras o Letras |
| DifficultySelectionView | Elegir nivel |
| CifrasGameView | Juego de números |
| LetrasGameView | Juego de letras |
| ResultsView | Mostrar resultados |
| StatsView | Ver estadísticas |
| SettingsView | Configuración |

## 🎨 Sistema de Diseño

### Colores

```swift
PrimaryColor: #1E3A8A (azul oscuro)
SecondaryColor: #FACC15 (amarillo/dorado)
BackgroundColor: #F3F4F6 (gris claro)
SecondaryTextColor: #6B7280 (gris medio)
```

### Tipografía

```swift
Títulos: 32pt, Bold, Rounded
Subtítulos: 24pt, Semibold
Cuerpo: 16pt, Regular
Números: 56pt, Bold, Rounded (para objetivos)
```

### Espaciados

```swift
Pequeño: 8-12pt
Medio: 16-20pt
Grande: 24-32pt
Margins: 24pt horizontal
```

## 🧪 Testing

### Estrategia de Tests

- **Unit Tests**: Services y ViewModels
- **UI Tests**: Flujos principales (futuro)
- **Integration Tests**: Coordinación entre capas (futuro)

### Cobertura Actual

```
CifrasGenerator: ✅ Tests completos
LetrasGenerator: ✅ Tests completos
ExpressionEvaluator: ✅ Tests completos
DictionaryService: ✅ Tests completos
ViewModels: ⚠️ Tests básicos (expandir en futuro)
```

## 📱 Compatibilidad

- **iOS**: 15.0+
- **iPhone**: Todos los modelos desde iPhone 6s
- **iPad**: Compatible pero optimizado para iPhone
- **Orientación**: Portrait (vertical)

## 🚀 Roadmap Futuro

### Versión 1.1
- [ ] Modo oscuro completo
- [ ] Animaciones mejoradas
- [ ] Sonidos y feedback háptico
- [ ] Más palabras en diccionario (10,000+)

### Versión 1.2
- [ ] Modo multijugador local
- [ ] iCloud sync para estadísticas
- [ ] Widget para pantalla de inicio
- [ ] Complicación para Apple Watch

### Versión 2.0
- [ ] Multijugador online
- [ ] Ranking global
- [ ] Sistema de logros
- [ ] Torneos y desafíos

## 📞 Contacto y Soporte

Para preguntas sobre el código o sugerencias:
- Revisar la documentación en este proyecto
- Verificar issues conocidos en los archivos de documentación
- Consultar la sección de troubleshooting en INSTALL.md

## 📄 Licencia

Este es un proyecto educativo demostrativo de desarrollo iOS con SwiftUI.

---

**Última actualización**: 2025-11-15
**Versión del proyecto**: 1.0.0
**Swift Version**: 5.5+
**Xcode Version**: 13.0+
