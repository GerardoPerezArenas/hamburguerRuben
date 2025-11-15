//
//  CifrasGeneratorTests.swift
//  CifrasYLetrasAppTests
//
//  Tests unitarios para el generador de cifras
//

import XCTest
@testable import CifrasYLetrasApp

class CifrasGeneratorTests: XCTestCase {
    
    var generator: CifrasGenerator!
    
    override func setUp() {
        super.setUp()
        generator = CifrasGenerator()
    }
    
    override func tearDown() {
        generator = nil
        super.tearDown()
    }
    
    // MARK: - Tests de Generación de Números
    
    func testGeneratesCorrectNumberCount() {
        // Given
        let difficulty = DifficultyLevel.intermedio
        
        // When
        let numbers = generator.generateNumbers(for: difficulty)
        
        // Then
        XCTAssertEqual(numbers.count, 6, "Debe generar exactamente 6 números")
    }
    
    func testGeneratedNumbersAreUnique() {
        // Given
        let difficulty = DifficultyLevel.profesional
        
        // When
        let numbers = generator.generateNumbers(for: difficulty)
        let uniqueNumbers = Set(numbers)
        
        // Then
        XCTAssertEqual(numbers.count, uniqueNumbers.count, "Todos los números deben ser únicos")
    }
    
    func testPrincipiante_GeneratesFavorableNumbers() {
        // Given
        let difficulty = DifficultyLevel.principiante
        
        // When
        let numbers = generator.generateNumbers(for: difficulty)
        let largeNumbers = numbers.filter { $0 >= 25 }
        
        // Then
        XCTAssertEqual(largeNumbers.count, 2, "Principiante debe tener exactamente 2 números grandes")
    }
    
    // MARK: - Tests de Generación de Objetivo
    
    func testTargetInRangeForPrincipiante() {
        // Given
        let difficulty = DifficultyLevel.principiante
        
        // When
        let target = generator.generateTarget(for: difficulty)
        
        // Then
        XCTAssertTrue((100...500).contains(target), "Objetivo debe estar en rango 100-500 para principiante")
    }
    
    func testTargetInRangeForIntermedio() {
        // Given
        let difficulty = DifficultyLevel.intermedio
        
        // When
        let target = generator.generateTarget(for: difficulty)
        
        // Then
        XCTAssertTrue((300...700).contains(target), "Objetivo debe estar en rango 300-700 para intermedio")
    }
    
    func testTargetInRangeForProfesional() {
        // Given
        let difficulty = DifficultyLevel.profesional
        
        // When
        let target = generator.generateTarget(for: difficulty)
        
        // Then
        XCTAssertTrue((100...999).contains(target), "Objetivo debe estar en rango 100-999 para profesional")
    }
    
    // MARK: - Tests de Búsqueda de Soluciones
    
    func testFindSolution_WhenTargetInNumbers() {
        // Given
        let numbers = [25, 50, 7, 3, 2, 8]
        let target = 25
        
        // When
        let solution = generator.findSolution(numbers: numbers, target: target)
        
        // Then
        XCTAssertNotNil(solution, "Debe encontrar solución cuando el objetivo está en los números")
    }
    
    func testFindApproximateSolutions_ReturnsResults() {
        // Given
        let numbers = [25, 50, 7, 3, 2, 8]
        let target = 100
        
        // When
        let solutions = generator.findApproximateSolutions(numbers: numbers, target: target)
        
        // Then
        XCTAssertFalse(solutions.isEmpty, "Debe encontrar al menos una solución aproximada")
        XCTAssertLessThanOrEqual(solutions.count, 5, "Debe retornar máximo 5 soluciones")
    }
}

// MARK: - Expression Evaluator Tests

class ExpressionEvaluatorTests: XCTestCase {
    
    var evaluator: ExpressionEvaluator!
    
    override func setUp() {
        super.setUp()
        evaluator = ExpressionEvaluator()
    }
    
    override func tearDown() {
        evaluator = nil
        super.tearDown()
    }
    
    // MARK: - Tests de Evaluación
    
    func testEvaluate_SimpleAddition() throws {
        // Given
        let expression = "25 + 50"
        
        // When
        let result = try evaluator.evaluate(expression)
        
        // Then
        XCTAssertEqual(result, 75)
    }
    
    func testEvaluate_SimpleSubtraction() throws {
        // Given
        let expression = "50 - 25"
        
        // When
        let result = try evaluator.evaluate(expression)
        
        // Then
        XCTAssertEqual(result, 25)
    }
    
    func testEvaluate_SimpleMultiplication() throws {
        // Given
        let expression = "7 × 8"
        
        // When
        let result = try evaluator.evaluate(expression)
        
        // Then
        XCTAssertEqual(result, 56)
    }
    
    func testEvaluate_SimpleDivision() throws {
        // Given
        let expression = "50 ÷ 2"
        
        // When
        let result = try evaluator.evaluate(expression)
        
        // Then
        XCTAssertEqual(result, 25)
    }
    
    func testEvaluate_ComplexExpression() throws {
        // Given
        let expression = "(25 + 50) * 2"
        
        // When
        let result = try evaluator.evaluate(expression)
        
        // Then
        XCTAssertEqual(result, 150)
    }
    
    func testEvaluate_ThrowsOnInvalidExpression() {
        // Given
        let expression = "25 + + 50"
        
        // When/Then
        XCTAssertThrowsError(try evaluator.evaluate(expression))
    }
    
    // MARK: - Tests de Validación
    
    func testValidate_ValidNumbers() {
        // Given
        let expression = "25 + 50"
        let availableNumbers = [25, 50, 7, 3, 2, 8]
        
        // When
        let isValid = evaluator.validate(expression: expression, withNumbers: availableNumbers)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidate_NumberNotAvailable() {
        // Given
        let expression = "100 + 50"
        let availableNumbers = [25, 50, 7, 3, 2, 8]
        
        // When
        let isValid = evaluator.validate(expression: expression, withNumbers: availableNumbers)
        
        // Then
        XCTAssertFalse(isValid, "Debe fallar cuando se usa un número no disponible")
    }
    
    func testValidate_NumberUsedTwice() {
        // Given
        let expression = "25 + 25"
        let availableNumbers = [25, 50, 7, 3, 2, 8]
        
        // When
        let isValid = evaluator.validate(expression: expression, withNumbers: availableNumbers)
        
        // Then
        XCTAssertFalse(isValid, "Debe fallar cuando se usa un número más de una vez")
    }
    
    // MARK: - Tests de Puntuación
    
    func testCalculateScore_ExactMatch() {
        // Given
        let result = 453
        let target = 453
        
        // When
        let score = evaluator.calculateScore(result: result, target: target)
        
        // Then
        XCTAssertEqual(score, 10, "Resultado exacto debe dar 10 puntos")
    }
    
    func testCalculateScore_CloseMatch() {
        // Given
        let result = 450
        let target = 453
        
        // When
        let score = evaluator.calculateScore(result: result, target: target)
        
        // Then
        XCTAssertEqual(score, 7, "Diferencia de 3 debe dar 7 puntos")
    }
    
    func testCalculateScore_MediumMatch() {
        // Given
        let result = 445
        let target = 453
        
        // When
        let score = evaluator.calculateScore(result: result, target: target)
        
        // Then
        XCTAssertEqual(score, 5, "Diferencia de 8 debe dar 5 puntos")
    }
    
    func testCalculateScore_NoMatch() {
        // Given
        let result = 400
        let target = 453
        
        // When
        let score = evaluator.calculateScore(result: result, target: target)
        
        // Then
        XCTAssertEqual(score, 0, "Diferencia mayor a 10 debe dar 0 puntos")
    }
}

// MARK: - Letras Generator Tests

class LetrasGeneratorTests: XCTestCase {
    
    var generator: LetrasGenerator!
    
    override func setUp() {
        super.setUp()
        generator = LetrasGenerator()
    }
    
    override func tearDown() {
        generator = nil
        super.tearDown()
    }
    
    func testGeneratesCorrectLetterCount_Principiante() {
        // Given
        let difficulty = DifficultyLevel.principiante
        
        // When
        let letters = generator.generateLetters(for: difficulty)
        
        // Then
        XCTAssertEqual(letters.count, 8, "Principiante debe generar 8 letras")
    }
    
    func testGeneratesCorrectLetterCount_Intermedio() {
        // Given
        let difficulty = DifficultyLevel.intermedio
        
        // When
        let letters = generator.generateLetters(for: difficulty)
        
        // Then
        XCTAssertEqual(letters.count, 9, "Intermedio debe generar 9 letras")
    }
    
    func testCanFormWord_ValidWord() {
        // Given
        let word = "CASA"
        let letters = ["C", "A", "S", "A", "M", "E", "R", "O"]
        
        // When
        let canForm = generator.canFormWord(word, with: letters)
        
        // Then
        XCTAssertTrue(canForm, "Debe poder formar 'CASA' con las letras dadas")
    }
    
    func testCanFormWord_InvalidWord() {
        // Given
        let word = "LIBRO"
        let letters = ["C", "A", "S", "A", "M", "E", "R", "O"]
        
        // When
        let canForm = generator.canFormWord(word, with: letters)
        
        // Then
        XCTAssertFalse(canForm, "No debe poder formar 'LIBRO' con las letras dadas")
    }
}

// MARK: - Dictionary Service Tests

class DictionaryServiceTests: XCTestCase {
    
    var service: DictionaryService!
    
    override func setUp() {
        super.setUp()
        service = DictionaryService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testIsValidWord_CommonWord() {
        // Given
        let word = "CASA"
        
        // When
        let isValid = service.isValidWord(word)
        
        // Then
        XCTAssertTrue(isValid, "CASA debe ser una palabra válida")
    }
    
    func testIsValidWord_InvalidWord() {
        // Given
        let word = "XYZQW"
        
        // When
        let isValid = service.isValidWord(word)
        
        // Then
        XCTAssertFalse(isValid, "XYZQW no debe ser una palabra válida")
    }
    
    func testIsValidWord_ShortWord() {
        // Given
        let word = "A"
        
        // When
        let isValid = service.isValidWord(word)
        
        // Then
        XCTAssertFalse(isValid, "Palabras de 1 letra no deben ser válidas")
    }
    
    func testDictionaryHasWords() {
        // When
        let count = service.wordCount
        
        // Then
        XCTAssertGreaterThan(count, 0, "El diccionario debe tener palabras cargadas")
    }
}
