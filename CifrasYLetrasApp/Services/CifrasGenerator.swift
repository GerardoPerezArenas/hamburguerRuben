//
//  CifrasGenerator.swift
//  CifrasYLetrasApp
//
//  Generador de números y objetivos para el modo Cifras
//

import Foundation

/// Generador de números para el juego de Cifras
class CifrasGenerator {
    
    // Números pequeños disponibles (1-10)
    private let smallNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    // Números grandes disponibles
    private let largeNumbers = [25, 50, 75, 100]
    
    /// Genera un conjunto de 6 números según el nivel de dificultad
    /// - Parameter difficulty: Nivel de dificultad
    /// - Returns: Array de 6 números para usar en el juego
    func generateNumbers(for difficulty: DifficultyLevel) -> [Int] {
        var numbers: [Int] = []
        
        switch difficulty {
        case .principiante:
            // 2 grandes, 4 pequeños - más fácil
            numbers.append(contentsOf: largeNumbers.shuffled().prefix(2))
            numbers.append(contentsOf: smallNumbers.shuffled().prefix(4))
            
        case .intermedio:
            // 2 grandes, 4 pequeños (aleatorio)
            let largeCount = Int.random(in: 1...3)
            numbers.append(contentsOf: largeNumbers.shuffled().prefix(largeCount))
            numbers.append(contentsOf: smallNumbers.shuffled().prefix(6 - largeCount))
            
        case .profesional:
            // Completamente aleatorio
            let largeCount = Int.random(in: 0...4)
            numbers.append(contentsOf: largeNumbers.shuffled().prefix(largeCount))
            numbers.append(contentsOf: smallNumbers.shuffled().prefix(6 - largeCount))
        }
        
        return numbers.shuffled()
    }
    
    /// Genera un número objetivo según el nivel de dificultad
    /// - Parameter difficulty: Nivel de dificultad
    /// - Returns: Número objetivo a alcanzar
    func generateTarget(for difficulty: DifficultyLevel) -> Int {
        let range = difficulty.cifrasTargetRange
        return Int.random(in: range)
    }
    
    /// Intenta encontrar una solución para un conjunto de números y objetivo
    /// Implementación básica de búsqueda recursiva
    /// - Parameters:
    ///   - numbers: Números disponibles
    ///   - target: Número objetivo
    /// - Returns: Expresión que alcanza el objetivo, si existe
    func findSolution(numbers: [Int], target: Int) -> String? {
        // Implementación simplificada - en producción usaríamos un algoritmo más sofisticado
        // Por ahora retorna nil, la solución completa requeriría búsqueda exhaustiva
        
        // Caso simple: el objetivo está en los números
        if numbers.contains(target) {
            return "\(target)"
        }
        
        // Para una implementación completa, necesitaríamos:
        // 1. Generar todas las combinaciones posibles de números
        // 2. Para cada combinación, probar todas las operaciones posibles
        // 3. Evaluar si el resultado coincide con el objetivo
        // Esto es computacionalmente costoso y requiere optimización
        
        return nil
    }
    
    /// Encuentra soluciones aproximadas al objetivo
    /// - Parameters:
    ///   - numbers: Números disponibles
    ///   - target: Número objetivo
    ///   - tolerance: Diferencia máxima aceptable
    /// - Returns: Array de posibles soluciones aproximadas
    func findApproximateSolutions(numbers: [Int], target: Int, tolerance: Int = 10) -> [String] {
        var solutions: [String] = []
        
        // Soluciones simples de dos números
        for i in 0..<numbers.count {
            for j in (i+1)..<numbers.count {
                let a = numbers[i]
                let b = numbers[j]
                
                // Suma
                if abs((a + b) - target) <= tolerance {
                    solutions.append("\(a) + \(b) = \(a + b)")
                }
                
                // Resta
                if abs((a - b) - target) <= tolerance {
                    solutions.append("\(a) - \(b) = \(a - b)")
                }
                
                // Multiplicación
                if abs((a * b) - target) <= tolerance {
                    solutions.append("\(a) × \(b) = \(a * b)")
                }
                
                // División
                if b != 0 && a % b == 0 && abs((a / b) - target) <= tolerance {
                    solutions.append("\(a) ÷ \(b) = \(a / b)")
                }
            }
        }
        
        return Array(solutions.prefix(5)) // Retornar máximo 5 sugerencias
    }
}
