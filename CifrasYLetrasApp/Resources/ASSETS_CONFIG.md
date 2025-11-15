# Assets.xcassets Configuration Guide

Este archivo describe cómo configurar los colores y recursos en Xcode.

## Configuración de Colores

### Paso 1: Abrir Assets.xcassets

1. En Xcode, navega a `Assets.xcassets` en el navegador de proyecto
2. Click derecho en el área de trabajo
3. Selecciona `New Color Set`

### Paso 2: Crear Color Sets

Crea los siguientes Color Sets con estos valores:

#### PrimaryColor
```
Name: PrimaryColor
Any Appearance: 
  - Color Space: sRGB
  - Hex: #1E3A8A
  - RGB: (30, 58, 138)

Dark Appearance:
  - Color Space: sRGB
  - Hex: #3B82F6
  - RGB: (59, 130, 246)
```

#### SecondaryColor
```
Name: SecondaryColor
Any Appearance:
  - Color Space: sRGB
  - Hex: #FACC15
  - RGB: (250, 204, 21)

Dark Appearance:
  - Color Space: sRGB
  - Hex: #FCD34D
  - RGB: (252, 211, 77)
```

#### BackgroundColor
```
Name: BackgroundColor
Any Appearance:
  - Color Space: sRGB
  - Hex: #F3F4F6
  - RGB: (243, 244, 246)

Dark Appearance:
  - Color Space: sRGB
  - Hex: #1F2937
  - RGB: (31, 41, 55)
```

#### SecondaryTextColor
```
Name: SecondaryTextColor
Any Appearance:
  - Color Space: sRGB
  - Hex: #6B7280
  - RGB: (107, 114, 128)

Dark Appearance:
  - Color Space: sRGB
  - Hex: #9CA3AF
  - RGB: (156, 163, 175)
```

### Paso 3: Uso en SwiftUI

```swift
// Usar colores en SwiftUI
Text("Hola")
    .foregroundColor(Color("PrimaryColor"))

Rectangle()
    .fill(Color("SecondaryColor"))

// El color se ajustará automáticamente según el modo (claro/oscuro)
```

## Configuración del Icono de la App

### AppIcon.appiconset

1. En `Assets.xcassets`, selecciona o crea `AppIcon`
2. Arrastra las imágenes del icono en los siguientes tamaños:

#### iOS App Icon (Required)

```
iPhone:
- 40x40 (@2x)     - 80x80 pixels
- 60x60 (@2x)     - 120x120 pixels
- 60x60 (@3x)     - 180x180 pixels

iPad:
- 20x20 (@1x)     - 20x20 pixels
- 20x20 (@2x)     - 40x40 pixels
- 29x29 (@1x)     - 29x29 pixels
- 29x29 (@2x)     - 58x58 pixels
- 40x40 (@1x)     - 40x40 pixels
- 40x40 (@2x)     - 80x80 pixels
- 76x76 (@1x)     - 76x76 pixels
- 76x76 (@2x)     - 152x152 pixels
- 83.5x83.5 (@2x) - 167x167 pixels

App Store:
- 1024x1024 (@1x) - 1024x1024 pixels (sin alpha channel)
```

### Diseño del Icono Propuesto

```
Características:
- Fondo: Degradado azul oscuro (#1E3A8A → #2563EB)
- Lado izquierdo: Número grande "24" en blanco
- Lado derecho: Letras "ABC" en blanco, ligeramente superpuestas
- Estilo: Flat, minimalista
- Sin texto del nombre de la app
- Bordes redondeados automáticos por iOS
```

### Herramientas Recomendadas para Crear el Icono

1. **Figma** (gratis)
   - Crear canvas de 1024x1024
   - Exportar en PNG

2. **SF Symbols App** (gratis de Apple)
   - Para iconos consistentes con iOS

3. **Icon Set Creator** (gratis)
   - Genera todos los tamaños automáticamente

### Exportación

```bash
# Asegúrate de que el icono de 1024x1024:
- Es PNG
- No tiene canal alpha (transparencia)
- Es exactamente 1024x1024 pixels
- Está en color space sRGB
```

## Recursos Adicionales

### dictionary_es.json

Ya está incluido en `Resources/dictionary_es.json`

Para añadirlo al bundle:
1. Arrastra el archivo a Xcode
2. Marca "Copy items if needed"
3. Asegúrate de que está marcado en "Target Membership"

### Localizable.strings

Ya está incluido en `Resources/Localizable.strings`

Para añadirlo:
1. Arrastra el archivo a Xcode
2. Marca "Copy items if needed"
3. En File Inspector, marca el idioma (Spanish)

## Verificación

### Checklist de Assets

- [ ] PrimaryColor creado con valores light y dark
- [ ] SecondaryColor creado con valores light y dark
- [ ] BackgroundColor creado con valores light y dark
- [ ] SecondaryTextColor creado con valores light y dark
- [ ] AppIcon con todos los tamaños necesarios
- [ ] dictionary_es.json en el bundle
- [ ] Localizable.strings configurado
- [ ] Todos los archivos tienen Target Membership correcto

### Probar en Xcode

```swift
// En un playground o preview
struct ColorTest: View {
    var body: some View {
        VStack {
            Text("Primary")
                .foregroundColor(Color("PrimaryColor"))
            Text("Secondary")
                .foregroundColor(Color("SecondaryColor"))
        }
        .background(Color("BackgroundColor"))
    }
}
```

## Troubleshooting

### Colores no se muestran

1. Verifica que el Color Set esté en Assets.xcassets
2. Verifica que el nombre sea exacto (case-sensitive)
3. Limpia build folder: Cmd + Shift + K
4. Rebuild: Cmd + B

### Icono no aparece

1. Verifica que AppIcon esté seleccionado en Target settings
2. Verifica que no haya canal alpha en el PNG de 1024x1024
3. Limpia y rebuild el proyecto

### dictionary_es.json no se carga

1. Verifica en Copy Bundle Resources en Build Phases
2. Debe estar en el target principal
3. El nombre debe ser exacto
