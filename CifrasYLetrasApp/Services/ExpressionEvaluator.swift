//
//  ExpressionEvaluator.swift
//  CifrasYLetrasApp
//
//  Evaluador de expresiones aritméticas
//

import Foundation

/// Evaluador de expresiones matemáticas para el modo Cifras
class ExpressionEvaluator {
    
    enum EvaluationError: Error {
        case invalidExpression
        case invalidCharacter
        case divisionByZero
        case numbersNotAvailable
        case numberUsedMultipleTimes
    }
    
    /// Evalúa una expresión aritmética
    /// - Parameter expression: Expresión a evaluar (ej: "25 + 50 * 2")
    /// - Returns: Resultado de la evaluación
    /// - Throws: EvaluationError si la expresión es inválida
    func evaluate(_ expression: String) throws -> Int {
        // Eliminar espacios
        let cleanExpression = expression.replacingOccurrences(of: " ", with: "")
        
        if cleanExpression.isEmpty {
            throw EvaluationError.invalidExpression
        }
        
        // Convertir a notación postfija y evaluar
        let result = try evaluateInfix(cleanExpression)
        
        return result
    }
    
    /// Valida que una expresión use solo números disponibles
    /// - Parameters:
    ///   - expression: Expresión a validar
    ///   - availableNumbers: Números que pueden usarse
    /// - Returns: true si la expresión es válida
    func validate(expression: String, withNumbers availableNumbers: [Int]) -> Bool {
        do {
            // Extraer números de la expresión
            let numbers = try extractNumbers(from: expression)
            
            // Verificar que cada número usado esté disponible
            var available = availableNumbers
            for number in numbers {
                if let index = available.firstIndex(of: number) {
                    available.remove(at: index)
                } else {
                    return false
                }
            }
            
            return true
        } catch {
            return false
        }
    }
    
    /// Extrae los números de una expresión
    private func extractNumbers(from expression: String) throws -> [Int] {
        var numbers: [Int] = []
        var currentNumber = ""
        
        for char in expression {
            if char.isNumber {
                currentNumber.append(char)
            } else if "+-×÷*/()".contains(char) {
                if !currentNumber.isEmpty {
                    if let number = Int(currentNumber) {
                        numbers.append(number)
                    }
                    currentNumber = ""
                }
            } else if char != " " {
                throw EvaluationError.invalidCharacter
            }
        }
        
        if !currentNumber.isEmpty {
            if let number = Int(currentNumber) {
                numbers.append(number)
            }
        }
        
        return numbers
    }
    
    /// Evalúa una expresión en notación infija
    private func evaluateInfix(_ expression: String) throws -> Int {
        // Implementación simplificada usando recursión
        // Soporta +, -, *, /, ×, ÷
        
        let normalized = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        
        // Usar NSExpression para evaluación segura
        // Nota: En producción, implementaríamos nuestro propio parser
        // para mayor control y seguridad
        
        let mathExpression = NSExpression(format: normalized)
        
        guard let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber else {
            throw EvaluationError.invalidExpression
        }
        
        return result.intValue
    }
    
    /// Calcula la distancia entre el resultado y el objetivo
    /// - Parameters:
    ///   - result: Resultado obtenido
    ///   - target: Número objetivo
    /// - Returns: Distancia absoluta
    func calculateDistance(result: Int, target: Int) -> Int {
        return abs(result - target)
    }
    
    /// Calcula la puntuación basada en la distancia
    /// - Parameters:
    ///   - result: Resultado obtenido
    ///   - target: Número objetivo
    /// - Returns: Puntuación (0-10)
    func calculateScore(result: Int, target: Int) -> Int {
        let distance = calculateDistance(result: result, target: target)
        
        if distance == 0 {
            return 10
        } else if distance <= 5 {
            return 7
        } else if distance <= 10 {
            return 5
        } else {
            return 0
        }
    }
}
