# Documentación de Diseño Visual

## Guía de Estilo Visual - iOS

Esta documentación describe el sistema de diseño visual para la aplicación "Cifras y Letras".

## 🎨 Paleta de Colores

### Colores Principales

```swift
// En Assets.xcassets, crear Color Sets:

PrimaryColor: #1E3A8A
- Dark mode: #3B82F6
- Uso: Cabeceras, títulos, botones principales, iconos

SecondaryColor: #FACC15  
- Dark mode: #FCD34D
- Uso: Acentos, destacados, puntuaciones, éxitos

BackgroundColor: #F3F4F6
- Dark mode: #1F2937
- Uso: Fondo principal de pantallas

SecondaryTextColor: #6B7280
- Dark mode: #9CA3AF
- Uso: Textos secundarios, descripciones, ayudas
```

### Colores Semánticos

```swift
Success: #10B981 (Verde)
Warning: #F59E0B (Naranja)
Error: #EF4444 (Rojo)
Info: #3B82F6 (Azul)
```

## 📐 Tipografía

### Jerarquía de Texto

```swift
// Títulos principales
.font(.system(size: 32, weight: .bold, design: .rounded))
Color: PrimaryColor

// Títulos de sección
.font(.system(size: 24, weight: .semibold, design: .rounded))
Color: PrimaryColor

// Subtítulos
.font(.system(size: 18, weight: .semibold))
Color: PrimaryColor

// Cuerpo de texto
.font(.system(size: 16, weight: .regular))
Color: PrimaryTextColor

// Texto secundario
.font(.system(size: 14))
Color: SecondaryTextColor

// Números grandes (objetivos, puntuaciones)
.font(.system(size: 56, weight: .bold, design: .rounded))
Color: PrimaryColor

// Números en fichas
.font(.system(size: 28, weight: .bold, design: .rounded))
Color: White (sobre fondo oscuro)
```

## 🔘 Componentes UI

### Botones

#### Botón Principal
```swift
- Altura: 50pt
- Padding horizontal: 24pt
- Radio de esquina: 12pt
- Fondo: PrimaryColor
- Texto: Blanco, 17pt, semibold
- Sombra: opacity 0.1, radius 5, y: 2
```

#### Botón Secundario
```swift
- Altura: 50pt
- Padding horizontal: 24pt
- Radio de esquina: 12pt
- Fondo: Blanco
- Texto: PrimaryColor, 17pt, semibold
- Borde: Gris 0.3 opacity, 1pt
- Sombra: opacity 0.05, radius 5, y: 2
```

### Tarjetas (Cards)

```swift
- Radio de esquina: 16pt
- Padding interno: 20-24pt
- Fondo: Blanco
- Sombra: opacity 0.05, radius 10, y: 5
- Espaciado entre tarjetas: 16-20pt
```

### Fichas de Números

```swift
- Tamaño: 70x70pt
- Radio de esquina: 12pt
- Fondo: PrimaryColor
- Texto: Blanco, 28pt, bold, rounded
- Sombra: opacity 0.1, radius 3, y: 3
- Estado usado: opacity 0.5, fondo gris
```

### Fichas de Letras

```swift
- Tamaño: 60x60pt
- Radio de esquina: 8pt
- Fondo: SecondaryColor
- Texto: PrimaryColor, 32pt, bold, rounded
- Sombra: opacity 0.1, radius 2, y: 2
- Estilo: Similar a fichas de Scrabble
```

### Cronómetro

```swift
- Icono: SF Symbol "clock.fill"
- Tamaño del icono: 20pt
- Texto: 20pt, bold, rounded, monospaced
- Fondo: Cápsula con gris 0.1 opacity
- Padding: 8pt vertical, 16pt horizontal
- Color normal: PrimaryColor
- Color alerta (≤10s): Rojo
- Animación: Scale 1.0 → 1.2 cuando tiempo bajo
```

## 📱 Pantallas Detalladas

### 1. Pantalla de Inicio (HomeView)

```
Layout:
┌─────────────────────────────────┐
│ Status Bar                      │
├─────────────────────────────────┤
│                                 │
│         [Spacer 20%]            │
│                                 │
│     Cifras y Letras             │ ← 32pt bold
│     El clásico concurso         │ ← 16pt regular
│     ahora en tu iPhone          │
│                                 │
│         [Spacer 30%]            │
│                                 │
│  ┌───────────────────────────┐  │
│  │    Jugar rápido          │  │ ← Botón primario
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │    Elegir modo           │  │ ← Botón secundario
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │    Ver estadísticas      │  │ ← Botón secundario
│  └───────────────────────────┘  │
│                                 │
│         [Spacer 20%]            │
│                                 │
│   Nivel actual: Intermedio      │ ← 14pt
│         [Ajustes]               │ ← 14pt link
│                                 │
└─────────────────────────────────┘

Margins:
- Horizontal: 24pt
- Vertical entre botones: 16pt
- Padding superior: Safe Area + 20pt
- Padding inferior: Safe Area + 32pt
```

### 2. Selección de Modo

```
Layout:
┌─────────────────────────────────┐
│  Elige modo de juego    [Cerrar]│
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐  │
│  │  🔢                       │  │
│  │  Cifras                  →│  │
│  │  Alcanza el número...     │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  🔤                       │  │
│  │  Letras                  →│  │
│  │  Forma la palabra...      │  │
│  └───────────────────────────┘  │
│                                 │
└─────────────────────────────────┘

Card Specs:
- Icono: 40pt a la izquierda
- Título: 22pt bold
- Descripción: 14pt, 2 líneas max
- Flecha derecha: chevron.right, gris
- Padding: 24pt
- Espaciado entre cards: 20pt
```

### 3. Juego de Cifras

```
Layout:
┌─────────────────────────────────┐
│ ← Cifras-Intermedio   ⏰ 45s   │
├─────────────────────────────────┤
│                                 │
│         Objetivo                │ ← 16pt
│           453                   │ ← 56pt bold
│                                 │
│    Números disponibles          │ ← 14pt
│    ┌────┐ ┌────┐ ┌────┐        │
│    │ 25 │ │ 50 │ │  7 │        │
│    └────┘ └────┘ └────┘        │
│    ┌────┐ ┌────┐ ┌────┐        │
│    │  3 │ │  2 │ │  8 │        │
│    └────┘ └────┘ └────┘        │
│                                 │
│    Tu expresión:                │ ← 14pt
│    ┌─────────────────────────┐  │
│    │   25 + 50 × 7          │  │ ← 24pt mono
│    └─────────────────────────┘  │
│                                 │
│    [ + ] [ − ] [ × ] [ ÷ ]     │
│    [ ( ] [ ) ] [ ← ] [ C ]     │
│                                 │
│         [Spacer]                │
│                                 │
│    [Error message if any]       │ ← 14pt red
│                                 │
│    ┌─────────────────────────┐  │
│    │   Validar solución      │  │
│    └─────────────────────────┘  │
│                                 │
└─────────────────────────────────┘

Grid Specs:
- Números: 3 columnas, spacing 12pt
- Operaciones: spacing 12pt
- Botones operación: height 50pt
```

### 4. Juego de Letras

```
Layout:
┌─────────────────────────────────┐
│ ← Letras-Intermedio   ⏰ 60s   │
├─────────────────────────────────┤
│                                 │
│  Forma la palabra más larga     │
│  posible                        │
│                                 │
│    Letras disponibles           │
│    ┌───┐ ┌───┐ ┌───┐          │
│    │ A │ │ E │ │ S │          │
│    └───┘ └───┘ └───┘          │
│    ┌───┐ ┌───┐ ┌───┐          │
│    │ T │ │ R │ │ M │          │
│    └───┘ └───┘ └───┘          │
│    ┌───┐ ┌───┐ ┌───┐          │
│    │ O │ │ N │ │ L │          │
│    └───┘ └───┘ └───┘          │
│                                 │
│    Tu palabra:                  │
│    ┌─────────────────────────┐  │
│    │      MAESTRO            │  │ ← 32pt bold
│    └─────────────────────────┘  │
│                                 │
│    [Borrar]    [Limpiar]        │
│                                 │
│    [Message area]               │
│    💡 Hay palabras de 7+ letras │
│                                 │
│    Puntuación: 7 puntos         │
│                                 │
│    ┌─────────────────────────┐  │
│    │   Validar palabra       │  │
│    └─────────────────────────┘  │
│    [Finalizar juego]            │
│                                 │
└─────────────────────────────────┘
```

### 5. Resultados

```
Layout:
┌─────────────────────────────────┐
│                                 │
│         Resultados              │ ← 32pt bold
│                                 │
│        ¡Muy bien!               │ ← 24pt semibold
│                                 │
│            7                    │ ← 64pt bold
│      Puntos obtenidos           │ ← 16pt
│                                 │
│  ┌─────────────────────────────┐│
│  │ Tu resultado:          451  ││
│  │ Objetivo:              453  ││
│  │ Diferencia:              2  ││
│  └─────────────────────────────┘│
│                                 │
│  Soluciones aproximadas         │
│  ┌─────────────────────────────┐│
│  │ 25 + 50 × 8 = 450          ││
│  │ (7 + 2) × 50 + 3 = 453     ││
│  └─────────────────────────────┘│
│                                 │
│  Estadísticas totales           │
│  ┌─────────┐  ┌─────────┐      │
│  │  Total  │  │  Mejor  │      │
│  │   142   │  │   10    │      │
│  └─────────┘  └─────────┘      │
│                                 │
│  ┌─────────────────────────────┐│
│  │    Volver a jugar          ││
│  └─────────────────────────────┘│
│  ┌─────────────────────────────┐│
│  │      Ir al menú            ││
│  └─────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

## 🎭 Animaciones

### Transiciones de Pantalla

```swift
// Navegación entre pantallas
.transition(.move(edge: .trailing))
.animation(.easeInOut(duration: 0.3))

// Modales
.transition(.opacity.combined(with: .scale))
.animation(.spring(response: 0.4, dampingFraction: 0.8))
```

### Interacciones

```swift
// Botones al presionar
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.easeInOut(duration: 0.1))

// Fichas al seleccionar
.scaleEffect(isSelected ? 0.9 : 1.0)
.animation(.easeInOut(duration: 0.1))

// Cronómetro en alerta
.scaleEffect(isLowTime ? 1.2 : 1.0)
.animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
```

### Feedback Visual

```swift
// Validación exitosa
- Color verde parpadeante
- Scale animation 1.0 → 1.1 → 1.0
- Duración: 0.3s

// Validación fallida
- Color rojo parpadeante
- Shake animation (translate X: -10 → 10 → 0)
- Duración: 0.5s
```

## 📐 Espaciados Estándar

```swift
// Sistema de espaciado 8pt
spacing_xs: 4pt
spacing_sm: 8pt
spacing_md: 12pt
spacing_lg: 16pt
spacing_xl: 20pt
spacing_xxl: 24pt
spacing_xxxl: 32pt

// Margins de pantalla
horizontal_margin: 24pt
vertical_margin: 20pt

// Safe areas
- Siempre respetar las safe areas
- Padding adicional cuando sea necesario
```

## 🌗 Modo Oscuro

Todos los colores deben tener variantes para modo oscuro en Assets:

```swift
PrimaryColor:
  Light: #1E3A8A
  Dark: #3B82F6

SecondaryColor:
  Light: #FACC15
  Dark: #FCD34D

BackgroundColor:
  Light: #F3F4F6
  Dark: #1F2937

Cards/Components:
  Light: #FFFFFF
  Dark: #374151
```

## ♿️ Accesibilidad

### Tamaños de Toque

```swift
// Mínimo recomendado por Apple
minimum_touch_target: 44x44pt

// Implementado en la app
buttons: 50pt height (cumple)
tiles: 60x60pt y 70x70pt (cumple)
```

### Contraste de Color

```swift
// WCAG AA compliance
- Texto normal: ratio 4.5:1
- Texto grande: ratio 3:1
- Componentes UI: ratio 3:1

// Verificar en Xcode Accessibility Inspector
```

### VoiceOver

```swift
// Labels descriptivos en todos los elementos
.accessibilityLabel("Botón jugar rápido")
.accessibilityHint("Inicia una partida con la configuración actual")
```

## 🎨 Iconografía

### SF Symbols Utilizados

```swift
// Modos
number.circle.fill - Cifras
textformat.abc - Letras

// Navegación
chevron.left - Volver
chevron.right - Siguiente

// Acciones
clock.fill - Cronómetro
delete.left - Borrar
trash - Limpiar
checkmark.circle.fill - Seleccionado

// Estados
chart.bar - Estadísticas
gearshape.fill - Ajustes
```

---

Esta guía debe usarse como referencia durante todo el desarrollo para mantener consistencia visual en toda la aplicación.
