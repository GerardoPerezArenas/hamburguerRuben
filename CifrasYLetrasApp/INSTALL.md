# Guía de Instalación y Ejecución

Esta guía proporciona instrucciones paso a paso para configurar y ejecutar la aplicación "Cifras y Letras" en Xcode.

## 📋 Requisitos Previos

### Software Necesario

- **macOS**: 12.0 (Monterey) o superior
- **Xcode**: 13.0 o superior
- **iOS Deployment Target**: 15.0 o superior

### Verificar Instalación

```bash
# Verificar versión de macOS
sw_vers

# Verificar versión de Xcode
xcodebuild -version

# Listar simuladores disponibles
xcrun simctl list devices
```

## 🚀 Instalación Paso a Paso

### Opción 1: Crear Proyecto Nuevo en Xcode

#### Paso 1: Crear Proyecto

1. Abre Xcode
2. Selecciona **File → New → Project**
3. Elige **iOS → App**
4. Configura:
   - **Product Name**: `CifrasYLetrasApp`
   - **Team**: Tu equipo de desarrollo (o None para testing)
   - **Organization Identifier**: `com.tuempresa` (o cualquier identificador)
   - **Interface**: **SwiftUI**
   - **Language**: **Swift**
   - **Deselecciona**: Use Core Data, Include Tests (los crearemos manualmente)
5. Elige ubicación y crea el proyecto

#### Paso 2: Configurar Estructura de Carpetas

1. En el navegador de proyecto (⌘1), click derecho en `CifrasYLetrasApp`
2. Selecciona **New Group** y crea las siguientes carpetas:
   - `Models`
   - `Views`
   - `Views/Components`
   - `ViewModels`
   - `Services`
   - `Resources`
   - `Tests`

#### Paso 3: Añadir Archivos del Proyecto

1. **Copiar archivos Swift**:
   - Arrastra los archivos de cada carpeta del repositorio a las carpetas correspondientes en Xcode
   - Marca **"Copy items if needed"**
   - Asegúrate de que estén seleccionados en **Target Membership**

2. **Añadir Recursos**:
   - Arrastra `dictionary_es.json` a la carpeta Resources
   - Arrastra `Localizable.strings` a la carpeta Resources
   - Marca **"Copy items if needed"**
   - Verifica que estén en el target

#### Paso 4: Configurar Assets

1. Abre `Assets.xcassets`
2. Sigue las instrucciones en `Resources/ASSETS_CONFIG.md` para crear:
   - Color Sets (PrimaryColor, SecondaryColor, etc.)
   - App Icon (opcional por ahora)

Ver detalles completos en: `CifrasYLetrasApp/Resources/ASSETS_CONFIG.md`

#### Paso 5: Configurar Info.plist (opcional)

Si necesitas cambiar el nombre de la app mostrado:

1. Abre `Info.plist`
2. Añade o modifica:
   - **Bundle display name**: `Cifras y Letras`
   - **Privacy - Camera Usage Description**: (si planeas añadir cámara)

#### Paso 6: Configurar Build Settings

1. Selecciona el proyecto en el navegador
2. Selecciona el target `CifrasYLetrasApp`
3. En **General**:
   - **Deployment Target**: iOS 15.0
   - **Supported Destinations**: iPhone
4. En **Build Settings**:
   - Busca "Swift Language Version"
   - Asegúrate de que esté en **Swift 5** o superior

### Opción 2: Usar Swift Package Manager (para modularizar)

Si prefieres una estructura más modular:

```swift
// Package.swift (crear en la raíz del proyecto)
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "CifrasYLetrasApp",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "CifrasYLetrasApp", targets: ["CifrasYLetrasApp"]),
    ],
    targets: [
        .target(name: "CifrasYLetrasApp", dependencies: []),
        .testTarget(name: "CifrasYLetrasAppTests", dependencies: ["CifrasYLetrasApp"]),
    ]
)
```

## ▶️ Ejecución

### Método 1: Desde Xcode (Recomendado)

1. **Seleccionar simulador**:
   - En la barra superior, click en el selector de destino
   - Elige un simulador (ej: iPhone 14)

2. **Compilar y ejecutar**:
   ```
   Presiona ⌘R (Cmd + R)
   ```

3. **Esperar a que compile**:
   - Primera compilación puede tomar 1-2 minutos
   - Compilaciones subsiguientes serán más rápidas

### Método 2: Línea de Comandos

```bash
# Navegar al directorio del proyecto
cd /path/to/CifrasYLetrasApp

# Listar esquemas disponibles
xcodebuild -list

# Compilar
xcodebuild -scheme CifrasYLetrasApp -sdk iphonesimulator

# Ejecutar en simulador específico
xcodebuild -scheme CifrasYLetrasApp \
           -destination 'platform=iOS Simulator,name=iPhone 14' \
           run
```

### Método 3: Dispositivo Físico

1. **Conectar iPhone** vía USB
2. **Confiar en el ordenador** (si es primera vez)
3. **Seleccionar tu iPhone** en el selector de destino
4. **Configurar equipo de desarrollo**:
   - En General → Signing & Capabilities
   - Selecciona tu equipo
5. **Ejecutar** (⌘R)

**Nota**: Para ejecutar en dispositivo físico, necesitas:
- Apple Developer Account (gratis para testing)
- iPhone con iOS 15.0 o superior

## 🧪 Ejecutar Tests

### Desde Xcode

1. **Abrir Test Navigator** (⌘6)
2. **Click en el diamante** junto a los tests que quieres ejecutar
3. O presiona **⌘U** para ejecutar todos los tests

### Línea de Comandos

```bash
# Ejecutar todos los tests
xcodebuild test \
  -scheme CifrasYLetrasApp \
  -destination 'platform=iOS Simulator,name=iPhone 14'

# Ejecutar tests específicos
xcodebuild test \
  -scheme CifrasYLetrasApp \
  -destination 'platform=iOS Simulator,name=iPhone 14' \
  -only-testing:CifrasYLetrasAppTests/CifrasGeneratorTests
```

## 🔍 Debugging

### Breakpoints

1. Click en el margen izquierdo del editor de código
2. Ejecuta la app en modo debug (⌘R)
3. La ejecución se pausará en el breakpoint

### Print Debugging

```swift
// Añadir prints para debugging
print("DEBUG: Estado del juego: \(gameState)")
print("DEBUG: Tiempo restante: \(timeRemaining)")
```

### View Hierarchy

1. Ejecuta la app
2. En la barra de debug, click en el icono de la jerarquía de vistas
3. Inspecciona la estructura de SwiftUI

### Memory Graph

1. Ejecuta la app
2. Click en el icono de grafo de memoria en la barra de debug
3. Inspecciona posibles memory leaks

## 📱 Previews en Xcode

SwiftUI permite previews en tiempo real:

```swift
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
```

1. Abre cualquier archivo de Vista
2. En el panel derecho, activa **Canvas** si no está visible
3. Click en **Resume** para ver el preview
4. Los cambios se actualizarán en tiempo real

## 🐛 Solución de Problemas Comunes

### Error: "Build Failed"

**Problema**: Errores de compilación

**Solución**:
```bash
# Limpiar build folder
Cmd + Shift + K

# Limpiar derived data
Cmd + Option + Shift + K

# Rebuild
Cmd + B
```

### Error: "Module Not Found"

**Problema**: Archivos no importados correctamente

**Solución**:
1. Verifica que todos los archivos tengan **Target Membership** marcado
2. Verifica que no haya errores de sintaxis
3. Limpia y rebuild

### Error: "Dictionary Not Found"

**Problema**: `dictionary_es.json` no se carga

**Solución**:
1. Verifica que `dictionary_es.json` esté en **Copy Bundle Resources**
2. En **Build Phases** → **Copy Bundle Resources**
3. Si no está, arrástralo ahí

### Error: "Color Not Found"

**Problema**: Colores personalizados no se encuentran

**Solución**:
1. Verifica que los Color Sets estén creados en `Assets.xcassets`
2. Los nombres son **case-sensitive**: `PrimaryColor` no es igual a `primaryColor`
3. Limpia y rebuild

### Simulador Muy Lento

**Solución**:
1. Cierra otras aplicaciones
2. Reduce el número de simuladores abiertos
3. En Simulator → Hardware → Erase All Content and Settings
4. Reinicia el Mac

### Previews No Funcionan

**Solución**:
1. **Editor → Canvas** para mostrar
2. Click en **Resume** en el canvas
3. Si sigue sin funcionar, limpia derived data
4. Asegúrate de que no hay errores de compilación

## 📊 Monitoreo de Rendimiento

### Instruments

Para analizar rendimiento:

1. **Product → Profile** (⌘I)
2. Elige un template:
   - **Time Profiler**: Para CPU usage
   - **Allocations**: Para memoria
   - **Leaks**: Para memory leaks
3. Ejecuta y analiza

### Console de Xcode

```bash
# Ver logs en tiempo real
# Window → Devices and Simulators → Selecciona tu dispositivo → View Device Logs
```

## 🔄 Actualizar la App

Cuando hagas cambios en el código:

1. **Hot Reload**: Algunos cambios se aplicarán automáticamente en Previews
2. **Full Rebuild**: Para cambios mayores, detén la app y ejecuta de nuevo (⌘R)
3. **Limpiar**: Si hay problemas, limpia (⌘⇧K) y rebuild

## 📦 Distribución (Futuro)

### TestFlight (Beta Testing)

1. Archive la app: **Product → Archive**
2. En Organizer, selecciona el archive
3. **Distribute App → App Store Connect**
4. Sigue el proceso de TestFlight

### App Store

1. Archive la app
2. **Distribute App → App Store Connect**
3. Completa metadata en App Store Connect
4. Envía para revisión

**Nota**: Necesitas Apple Developer Program ($99/año) para distribución.

## 📚 Recursos Adicionales

### Documentación

- [Documentación del Proyecto](README.md)
- [Guía de Diseño](DESIGN.md)
- [Arquitectura](ARCHITECTURE.md)
- [Configuración de Assets](Resources/ASSETS_CONFIG.md)

### Enlaces Útiles

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Swift Language Guide](https://docs.swift.org/swift-book/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### Atajos de Teclado Útiles

```
⌘R - Run
⌘. - Stop
⌘B - Build
⌘U - Test
⌘⇧K - Clean Build Folder
⌘0 - Toggle Navigator
⌘⌥0 - Toggle Inspector
⌘/ - Comment/Uncomment
⌘⇧O - Open Quickly
⌘⇧F - Find in Project
```

## ✅ Checklist de Verificación

Antes de ejecutar por primera vez:

- [ ] Xcode instalado y actualizado
- [ ] Proyecto creado con configuración correcta
- [ ] Todas las carpetas creadas (Models, Views, etc.)
- [ ] Todos los archivos .swift copiados
- [ ] Target Membership verificado para todos los archivos
- [ ] dictionary_es.json en Copy Bundle Resources
- [ ] Color Sets creados en Assets.xcassets
- [ ] Deployment Target configurado a iOS 15.0
- [ ] Simulador seleccionado
- [ ] Primer build exitoso (⌘B)

Después del primer build exitoso:

- [ ] App se ejecuta en simulador (⌘R)
- [ ] Navegación funciona correctamente
- [ ] Colores se muestran correctamente
- [ ] Tests pasan (⌘U)
- [ ] Previews funcionan en archivos de vistas

---

**¡Listo!** Ahora deberías poder ejecutar y desarrollar la aplicación "Cifras y Letras". 🎮

Si encuentras problemas no cubiertos aquí, revisa la sección de **Solución de Problemas** o consulta la documentación de Apple.
