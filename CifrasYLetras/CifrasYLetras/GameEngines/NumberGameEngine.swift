//
//  NumberGameEngine.swift
//  CifrasYLetras
//
//  Game engine for validating number solutions
//

import Foundation

/// Handles the logic and validation for the numbers game
class NumberGameEngine {
    
    /// Represents an arithmetic operation
    enum Operation: String, CaseIterable {
        case add = "+"
        case subtract = "-"
        case multiply = "×"
        case divide = "÷"
        
        func apply(_ a: Int, _ b: Int) -> Int? {
            switch self {
            case .add:
                return a + b
            case .subtract:
                return a >= b ? a - b : nil // No negative results
            case .multiply:
                return a * b
            case .divide:
                return (b != 0 && a % b == 0) ? a / b : nil // Only exact divisions
            }
        }
    }
    
    /// Parse and validate a mathematical expression
    /// Format: "number operator number operator number..."
    /// Example: "50 + 25 × 2 - 10"
    func validateSolution(_ solution: String, with numbers: [Int], target: Int) -> (isValid: Bool, result: Int?, message: String) {
        // Clean the input
        let cleaned = solution.trimmingCharacters(in: .whitespaces)
        
        guard !cleaned.isEmpty else {
            return (false, nil, "Introduce una solución")
        }
        
        // Parse the expression
        let components = cleaned.components(separatedBy: " ")
        
        guard components.count >= 1 else {
            return (false, nil, "Formato inválido")
        }
        
        // Try to evaluate the expression
        if let result = evaluateExpression(components, availableNumbers: numbers) {
            let difference = abs(result - target)
            
            if result == target {
                return (true, result, "¡Perfecto! Resultado exacto: \(result)")
            } else if difference <= 10 {
                return (true, result, "¡Muy cerca! Resultado: \(result) (diferencia: \(difference))")
            } else {
                return (true, result, "Resultado: \(result) (diferencia: \(difference))")
            }
        } else {
            return (false, nil, "Expresión inválida o números incorrectos")
        }
    }
    
    /// Evaluate a mathematical expression given as components
    private func evaluateExpression(_ components: [String], availableNumbers: [Int]) -> Int? {
        var usedNumbers = availableNumbers
        var currentResult: Int? = nil
        var pendingOperation: Operation? = nil
        
        for component in components {
            // Try to parse as number
            if let number = Int(component) {
                // Check if this number is available
                if let index = usedNumbers.firstIndex(of: number) {
                    usedNumbers.remove(at: index)
                    
                    if let result = currentResult, let op = pendingOperation {
                        // Apply pending operation
                        if let newResult = op.apply(result, number) {
                            currentResult = newResult
                            pendingOperation = nil
                        } else {
                            return nil // Invalid operation (e.g., division by zero)
                        }
                    } else {
                        currentResult = number
                    }
                } else {
                    return nil // Number not available
                }
            }
            // Try to parse as operation
            else if let op = Operation.allCases.first(where: { $0.rawValue == component }) {
                pendingOperation = op
            }
        }
        
        // Make sure we don't have a pending operation at the end
        guard pendingOperation == nil else {
            return nil
        }
        
        return currentResult
    }
    
    /// Find a solution for the target number using the available numbers
    /// This is a simplified version - a full implementation would use more sophisticated algorithms
    func findSolution(target: Int, numbers: [Int]) -> String? {
        // Simple approach: try basic combinations
        
        // Try single numbers
        for num in numbers where num == target {
            return "\(num)"
        }
        
        // Try two-number combinations
        for i in 0..<numbers.count {
            for j in 0..<numbers.count where i != j {
                for op in Operation.allCases {
                    if let result = op.apply(numbers[i], numbers[j]), result == target {
                        return "\(numbers[i]) \(op.rawValue) \(numbers[j])"
                    }
                }
            }
        }
        
        // For more complex solutions, a full recursive algorithm would be needed
        return nil
    }
}
