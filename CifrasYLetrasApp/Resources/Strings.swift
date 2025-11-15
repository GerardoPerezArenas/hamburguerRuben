//
//  Strings.swift
//  CifrasYLetrasApp
//
//  Acceso tipado a cadenas de texto localizadas
//

import Foundation

/// Estructura para acceso tipado a cadenas localizadas
enum Strings {
    
    // MARK: - Títulos
    static let appTitle = NSLocalizedString("app_title", comment: "Título de la aplicación")
    static let chooseModeTitle = NSLocalizedString("choose_mode_title", comment: "Título de selección de modo")
    static let selectDifficultyTitle = NSLocalizedString("select_difficulty_title", comment: "Título de selección de dificultad")
    static let resultsTitle = NSLocalizedString("results_title", comment: "Título de resultados")
    static let settingsTitle = NSLocalizedString("settings_title", comment: "Título de ajustes")
    static let statsTitle = NSLocalizedString("stats_title", comment: "Título de estadísticas")
    
    // MARK: - Botones
    static let playQuick = NSLocalizedString("play_quick", comment: "Botón jugar rápido")
    static let chooseMode = NSLocalizedString("choose_mode", comment: "Botón elegir modo")
    static let viewStats = NSLocalizedString("view_stats", comment: "Botón ver estadísticas")
    static let beginner = NSLocalizedString("beginner", comment: "Nivel principiante")
    static let intermediate = NSLocalizedString("intermediate", comment: "Nivel intermedio")
    static let professional = NSLocalizedString("professional", comment: "Nivel profesional")
    static let numbers = NSLocalizedString("numbers", comment: "Modo cifras")
    static let letters = NSLocalizedString("letters", comment: "Modo letras")
    static let validateSolution = NSLocalizedString("validate_solution", comment: "Validar solución")
    static let validateWord = NSLocalizedString("validate_word", comment: "Validar palabra")
    static let deleteLetter = NSLocalizedString("delete_letter", comment: "Borrar letra")
    static let clearWord = NSLocalizedString("clear_word", comment: "Limpiar palabra")
    static let playAgain = NSLocalizedString("play_again", comment: "Volver a jugar")
    static let goToMenu = NSLocalizedString("go_to_menu", comment: "Ir al menú")
    static let close = NSLocalizedString("close", comment: "Cerrar")
    static let cancel = NSLocalizedString("cancel", comment: "Cancelar")
    static let settings = NSLocalizedString("settings", comment: "Ajustes")
    
    // MARK: - Mensajes de error
    static let invalidExpression = NSLocalizedString("invalid_expression", comment: "Expresión no válida")
    static let numberNotAvailable = NSLocalizedString("number_not_available", comment: "Número no disponible")
    static let invalidWord = NSLocalizedString("invalid_word", comment: "Palabra no válida")
    static let wordAlreadyUsed = NSLocalizedString("word_already_used", comment: "Palabra ya usada")
    static let timeUp = NSLocalizedString("time_up", comment: "Tiempo terminado")
    
    // MARK: - Estadísticas
    static let totalScore = NSLocalizedString("total_score", comment: "Puntuación total")
    static let bestScore = NSLocalizedString("best_score", comment: "Mejor puntuación")
    static let gamesPlayed = NSLocalizedString("games_played", comment: "Partidas jugadas")
    static let averageScore = NSLocalizedString("average_score", comment: "Promedio")
}
