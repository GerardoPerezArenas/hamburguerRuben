# Cifras y Letras - iOS Game App

Una aplicación iOS completa que reproduce el juego clásico de televisión "Cifras y Letras" (Numbers and Letters).

## 📱 Descripción

**Cifras y Letras** es una app móvil para iPhone (iOS) que permite a los usuarios jugar a las dos modalidades del programa de televisión clásico:

- **Prueba de Cifras**: Alcanzar un número objetivo usando operaciones aritméticas
- **Prueba de Letras**: Formar la palabra válida más larga posible usando letras aleatorias

## ✨ Características

### Modos de Juego

1. **Cifras (Números)**
   - 6 números disponibles (mezcla de grandes y pequeños)
   - Número objetivo aleatorio
   - Evaluador de expresiones aritméticas
   - Sistema de puntuación basado en precisión
   - Algoritmo de sugerencias de soluciones

2. **Letras**
   - 8-9 letras con distribución realista del español
   - Diccionario integrado de palabras válidas
   - Sistema de puntuación basado en longitud
   - Validación de palabras formables

### Niveles de Dificultad

- **Principiante**: Más tiempo (90s), retos sencillos
- **Intermedio**: Tiempo balanceado (60s), dificultad media
- **Profesional**: Poco tiempo (45s), retos complejos

### Funcionalidades Adicionales

- Cronómetro con alertas visuales
- Sistema de puntuación persistente
- Historial de partidas
- Estadísticas acumuladas
- Diseño responsive y accesible
- Interfaz moderna con SwiftUI

## 🏗 Arquitectura

El proyecto sigue el patrón **MVVM (Model-View-ViewModel)** y está organizado en las siguientes capas:

```
CifrasYLetrasApp/
├── App/                    # Punto de entrada
│   └── CifrasYLetrasApp.swift
├── Models/                 # Modelos de datos
│   ├── GameMode.swift
│   ├── DifficultyLevel.swift
│   ├── CifrasGameState.swift
│   ├── LetrasGameState.swift
│   ├── Score.swift
│   └── UserStats.swift
├── ViewModels/            # Lógica de presentación
│   ├── HomeViewModel.swift
│   ├── CifrasViewModel.swift
│   ├── LetrasViewModel.swift
│   ├── ResultsViewModel.swift
│   └── SettingsViewModel.swift
├── Views/                 # Interfaz de usuario
│   ├── HomeView.swift
│   ├── ModeSelectionView.swift
│   ├── DifficultySelectionView.swift
│   ├── GameView.swift
│   ├── CifrasGameView.swift
│   ├── LetrasGameView.swift
│   ├── ResultsView.swift
│   ├── StatsView.swift
│   ├── SettingsView.swift
│   └── Components/        # Componentes reutilizables
│       ├── PrimaryButton.swift
│       ├── TimerView.swift
│       ├── LetterTileView.swift
│       └── NumberTileView.swift
├── Services/              # Lógica de negocio
│   ├── CifrasGenerator.swift
│   ├── LetrasGenerator.swift
│   ├── ExpressionEvaluator.swift
│   ├── DictionaryService.swift
│   ├── StatsService.swift
│   └── DifficultyService.swift
└── Resources/             # Recursos
    ├── dictionary_es.json
    ├── Localizable.strings
    └── Strings.swift
```

## 🎨 Diseño

### Paleta de Colores

- **Color Primario**: Azul oscuro (#1E3A8A) - Cabecera y elementos principales
- **Color Secundario**: Amarillo/Dorado (#FACC15) - Acentos y botones destacados
- **Fondo**: Gris muy claro (#F3F4F6)
- **Texto Principal**: Casi negro (#111827)
- **Texto Secundario**: Gris medio (#6B7280)

### Tipografía

- **Títulos**: SF Pro Display, Semibold, 24-32pt
- **Texto normal**: SF Pro Text, Regular, 14-17pt
- **Números**: SF Pro Rounded para mejor legibilidad

### Iconos

Se utilizan SF Symbols nativos de iOS:
- `number.circle.fill` - Modo Cifras
- `textformat.abc` - Modo Letras
- `clock.fill` - Cronómetro
- Y muchos más...

## 🔧 Requisitos Técnicos

- **Lenguaje**: Swift 5.5+
- **Framework**: SwiftUI
- **Plataforma**: iOS 15.0+
- **Arquitectura**: MVVM
- **Persistencia**: UserDefaults
- **Sin dependencias externas** (librería estándar de Swift)

## 🚀 Cómo Ejecutar

### Requisitos Previos

1. macOS 12.0 o superior
2. Xcode 13.0 o superior
3. Simulador iOS o dispositivo físico con iOS 15.0+

### Pasos de Instalación

1. **Crear un nuevo proyecto en Xcode**:
   ```
   File > New > Project > iOS > App
   - Product Name: CifrasYLetrasApp
   - Interface: SwiftUI
   - Language: Swift
   ```

2. **Copiar los archivos**:
   - Copia toda la estructura de carpetas `CifrasYLetrasApp/` al proyecto de Xcode
   - Asegúrate de incluir los archivos en el target

3. **Configurar colores personalizados**:
   - Ve a `Assets.xcassets`
   - Crea un nuevo Color Set llamado "PrimaryColor" con valor #1E3A8A
   - Crea "SecondaryColor" con valor #FACC15
   - Crea "BackgroundColor" con valor #F3F4F6
   - Crea "SecondaryTextColor" con valor #6B7280

4. **Añadir dictionary_es.json al Bundle**:
   - Arrastra `dictionary_es.json` al proyecto
   - Marca "Copy items if needed"
   - Asegúrate de que está en el target

5. **Compilar y ejecutar**:
   ```
   Cmd + R
   ```

### Ejecución en Simulador

```bash
# Listar simuladores disponibles
xcrun simctl list devices

# Ejecutar en un simulador específico
xcodebuild -scheme CifrasYLetrasApp \
           -destination 'platform=iOS Simulator,name=iPhone 14' \
           run
```

## 🧪 Pruebas

### Pruebas Manuales Recomendadas

1. **Modo Cifras**:
   - Verificar generación de números aleatorios
   - Probar expresiones válidas: `25 + 50`, `(7 + 3) × 10`
   - Probar expresiones inválidas
   - Verificar cálculo de puntuación

2. **Modo Letras**:
   - Verificar generación de letras
   - Probar palabras válidas del diccionario
   - Probar palabras que no se pueden formar
   - Verificar palabras duplicadas

3. **Cronómetro**:
   - Verificar que cuenta correctamente
   - Verificar alerta visual en últimos 10 segundos
   - Verificar finalización automática

4. **Persistencia**:
   - Cerrar y reabrir la app
   - Verificar que las estadísticas se mantienen
   - Probar reseteo de estadísticas

## 📊 Sistema de Puntuación

### Cifras

- **10 puntos**: Resultado exacto
- **7 puntos**: Diferencia de 1-5
- **5 puntos**: Diferencia de 6-10
- **0 puntos**: Diferencia mayor

### Letras

- **N puntos**: Palabra válida de N letras
- Ejemplo: "CASA" = 4 puntos, "ESTRELLA" = 8 puntos

## 🎯 Flujo de Usuario

```
┌─────────────┐
│   Inicio    │
│             │
│ - Jugar     │
│ - Modo      │
│ - Stats     │
└──────┬──────┘
       │
       ├───────────┐
       │           │
┌──────▼──────┐ ┌─▼──────────┐
│  Selección  │ │ Selección  │
│    Modo     │ │ Dificultad │
└──────┬──────┘ └─┬──────────┘
       │           │
       └─────┬─────┘
             │
    ┌────────▼────────┐
    │  Juego Activo   │
    │                 │
    │ - Cifras/Letras │
    │ - Cronómetro    │
    │ - Validación    │
    └────────┬────────┘
             │
      ┌──────▼──────┐
      │  Resultados  │
      │             │
      │ - Puntos    │
      │ - Soluciones│
      │ - Stats     │
      └──────┬──────┘
             │
       ┌─────┴─────┐
       │           │
┌──────▼──────┐ ┌─▼────────┐
│ Volver a    │ │ Ir al    │
│   Jugar     │ │  Menú    │
└─────────────┘ └──────────┘
```

## 🎨 Mockups Conceptuales

### Pantalla de Inicio
```
┌─────────────────────────┐
│                         │
│   Cifras y Letras      │
│   El clásico concurso   │
│   ahora en tu iPhone    │
│                         │
│  ┌───────────────────┐  │
│  │   Jugar rápido    │  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │   Elegir modo     │  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │ Ver estadísticas  │  │
│  └───────────────────┘  │
│                         │
│ Nivel: Intermedio       │
│      [Ajustes]          │
└─────────────────────────┘
```

### Pantalla de Juego - Cifras
```
┌─────────────────────────┐
│ ← Cifras    ⏰ 45s      │
├─────────────────────────┤
│       Objetivo          │
│         453             │
│                         │
│  Números disponibles    │
│  ┌──┐ ┌──┐ ┌──┐        │
│  │25│ │50│ │7 │        │
│  └──┘ └──┘ └──┘        │
│  ┌──┐ ┌──┐ ┌──┐        │
│  │3 │ │2 │ │8 │        │
│  └──┘ └──┘ └──┘        │
│                         │
│  Tu expresión:          │
│  ┌───────────────────┐  │
│  │ 50 + 7 × 3        │  │
│  └───────────────────┘  │
│                         │
│  [ + ][ - ][ × ][ ÷ ]  │
│  [ ( ][ ) ][ ← ][ C ]  │
│                         │
│  ┌───────────────────┐  │
│  │ Validar solución  │  │
│  └───────────────────┘  │
└─────────────────────────┘
```

### Pantalla de Juego - Letras
```
┌─────────────────────────┐
│ ← Letras    ⏰ 60s      │
├─────────────────────────┤
│ Forma la palabra más    │
│ larga posible           │
│                         │
│  Letras disponibles     │
│  ┌──┐ ┌──┐ ┌──┐        │
│  │A │ │E │ │S │        │
│  └──┘ └──┘ └──┘        │
│  ┌──┐ ┌──┐ ┌──┐        │
│  │T │ │R │ │M │        │
│  └──┘ └──┘ └──┘        │
│  ┌──┐ ┌──┐ ┌──┐        │
│  │O │ │N │ │L │        │
│  └──┘ └──┘ └──┘        │
│                         │
│  Tu palabra:            │
│  ┌───────────────────┐  │
│  │    MAESTRO        │  │
│  └───────────────────┘  │
│                         │
│  [Borrar] [Limpiar]     │
│                         │
│  Puntuación: 7 puntos   │
│                         │
│  ┌───────────────────┐  │
│  │ Validar palabra   │  │
│  └───────────────────┘  │
└─────────────────────────┘
```

## 📱 Configuración del Icono

### Especificaciones del Icono

El icono de la app debe cumplir con las guías de Apple:

**Diseño propuesto**:
- Fondo: Degradado azul oscuro (#1E3A8A → #1E5A8A)
- Parte izquierda: Número "24" en blanco, bold
- Parte derecha: Letras "ABC" en blanco, superpuestas
- Estilo: Plano, moderno, sin texto de app
- Bordes: Redondeados según iOS

**Tamaños requeridos** (en Assets.xcassets/AppIcon.appiconset):
- iPhone: 120x120 (@2x), 180x180 (@3x)
- iPad: 152x152 (@2x), 167x167 (@2x)
- App Store: 1024x1024

## 🔮 Futuras Mejoras

### Funcionalidades Propuestas

1. **Modo Multijugador**
   - Duelos online en tiempo real
   - Sistema de emparejamiento
   - Chat entre jugadores

2. **Ranking Global**
   - Tabla de clasificación mundial
   - Rankings por país/región
   - Logros y medallas

3. **Modo Torneo**
   - Competiciones periódicas
   - Premios y recompensas
   - Sistema de ligas

4. **Más Características**
   - Modo práctica sin límite de tiempo
   - Desafíos diarios
   - Compartir resultados en redes sociales
   - Modo oscuro
   - Más idiomas (Catalán, Inglés, Francés)
   - Accesibilidad mejorada (VoiceOver)
   - Apple Watch companion app
   - Widget para pantalla de inicio

5. **Mejoras Técnicas**
   - Algoritmo de búsqueda más sofisticado para Cifras
   - Diccionario más completo (50,000+ palabras)
   - Sincronización con iCloud
   - Análisis con Core ML
   - Animaciones mejoradas
   - Sonidos y efectos

## 📄 Licencia

Este proyecto es un ejemplo educativo creado para demostrar el desarrollo de aplicaciones iOS con SwiftUI.

## 👥 Créditos

- Concepto original: Programa de TV "Cifras y Letras"
- Desarrollo: iOS App en SwiftUI
- Diccionario: Palabras comunes del español

## 📞 Soporte

Para reportar problemas o sugerencias:
1. Revisar la documentación
2. Verificar los logs en Xcode
3. Comprobar la configuración del proyecto

---

**¡Disfruta jugando a Cifras y Letras!** 🎮🎯
