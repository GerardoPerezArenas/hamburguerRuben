//
//  DictionaryService.swift
//  CifrasYLetrasApp
//
//  Servicio de validación de palabras usando diccionario
//

import Foundation

/// Servicio de validación de palabras en español
class DictionaryService {
    
    private var dictionary: Set<String> = []
    private let dictionaryFileName = "dictionary_es.json"
    
    init() {
        loadDictionary()
    }
    
    /// Carga el diccionario desde el archivo JSON
    private func loadDictionary() {
        // Intentar cargar desde el bundle
        guard let url = Bundle.main.url(forResource: "dictionary_es", withExtension: "json") else {
            // Si no existe, usar diccionario básico
            loadBasicDictionary()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([String].self, from: data)
            dictionary = Set(words.map { $0.uppercased() })
        } catch {
            print("Error loading dictionary: \(error)")
            loadBasicDictionary()
        }
    }
    
    /// Carga un diccionario básico en memoria
    private func loadBasicDictionary() {
        // Diccionario básico con palabras comunes en español
        let basicWords = [
            "CASA", "MESA", "SILLA", "AMOR", "VIDA", "MUNDO", "TIEMPO", "AGUA",
            "TIERRA", "FUEGO", "AIRE", "SOL", "LUNA", "ESTRELLA", "CIELO", "MAR",
            "RIO", "MONTAÑA", "VALLE", "CAMPO", "CIUDAD", "PUEBLO", "CALLE", "CAMINO",
            "HOMBRE", "MUJER", "NIÑO", "NIÑA", "PADRE", "MADRE", "HERMANO", "HERMANA",
            "AMIGO", "AMIGA", "FAMILIA", "GENTE", "PERSONA", "NOMBRE", "COSA", "LUGAR",
            "DIA", "NOCHE", "MAÑANA", "TARDE", "AÑO", "MES", "SEMANA", "HORA", "MINUTO",
            "GRANDE", "PEQUEÑO", "ALTO", "BAJO", "LARGO", "CORTO", "ANCHO", "ESTRECHO",
            "BUENO", "MALO", "NUEVO", "VIEJO", "JOVEN", "FELIZ", "TRISTE", "ALEGRE",
            "NEGRO", "BLANCO", "ROJO", "AZUL", "VERDE", "AMARILLO", "NARANJA", "ROSA",
            "UNO", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE", "DIEZ",
            "PRIMERO", "SEGUNDO", "TERCERO", "ULTIMO", "MEDIO", "TODO", "NADA", "ALGO",
            "SER", "ESTAR", "HABER", "HACER", "PODER", "DECIR", "IR", "VER", "DAR", "SABER",
            "QUERER", "LLEGAR", "PASAR", "DEBER", "PONER", "PARECER", "QUEDAR", "CREER", "HABLAR",
            "LLEVAR", "DEJAR", "SEGUIR", "ENCONTRAR", "LLAMAR", "VENIR", "PENSAR", "SALIR",
            "VOLVER", "TOMAR", "CONOCER", "VIVIR", "SENTIR", "TRATAR", "MIRAR", "CONTAR",
            "EMPEZAR", "ESPERAR", "BUSCAR", "EXISTIR", "ENTRAR", "TRABAJAR", "ESCRIBIR",
            "PERDER", "PRODUCIR", "OCURRIR", "ENTENDER", "PEDIR", "RECIBIR", "RECORDAR",
            "TERMINAR", "PERMITIR", "APARECER", "CONSEGUIR", "COMENZAR", "SERVIR", "SACAR",
            "LIBRO", "PAPEL", "PALABRA", "LETRA", "NUMERO", "LINEA", "PAGINA", "TEXTO",
            "MANO", "PIE", "OJO", "OREJA", "NARIZ", "BOCA", "DIENTE", "LENGUA", "CABEZA",
            "CUELLO", "HOMBRO", "BRAZO", "CODO", "MUÑECA", "DEDO", "PECHO", "ESPALDA",
            "ESTOMAGO", "PIERNA", "RODILLA", "TOBILLO", "TALON", "CORAZON", "SANGRE",
            "PAN", "CARNE", "PESCADO", "HUEVO", "LECHE", "QUESO", "FRUTA", "VERDURA",
            "ARROZ", "PASTA", "SOPA", "ENSALADA", "POSTRE", "CAFE", "TE", "VINO", "CERVEZA",
            "PERRO", "GATO", "CABALLO", "VACA", "CERDO", "OVEJA", "GALLINA", "PAJARO",
            "PEZ", "LEON", "TIGRE", "ELEFANTE", "MONO", "OSO", "LOBO", "ZORRO", "CONEJO",
            "ARBOL", "FLOR", "HOJA", "RAMA", "RAIZ", "HIERBA", "PLANTA", "JARDIN", "BOSQUE",
            "COCHE", "AUTOBUS", "TREN", "AVION", "BARCO", "BICICLETA", "MOTO", "CAMION",
            "ORDENADOR", "TELEFONO", "TELEVISION", "RADIO", "CAMARA", "RELOJ", "LAMPARA",
            "VENTANA", "PUERTA", "PARED", "SUELO", "TECHO", "ESCALERA", "COCINA", "BAÑO"
        ]
        
        dictionary = Set(basicWords)
    }
    
    /// Valida si una palabra existe en el diccionario
    /// - Parameter word: Palabra a validar
    /// - Returns: true si la palabra es válida
    func isValidWord(_ word: String) -> Bool {
        let normalized = word.uppercased().trimmingCharacters(in: .whitespaces)
        
        // Las palabras de menos de 2 letras no son válidas
        if normalized.count < 2 {
            return false
        }
        
        return dictionary.contains(normalized)
    }
    
    /// Busca palabras en el diccionario que puedan formarse con las letras dadas
    /// - Parameters:
    ///   - letters: Letras disponibles
    ///   - minLength: Longitud mínima de palabra
    /// - Returns: Array de palabras posibles, ordenadas por longitud
    func findPossibleWords(with letters: [String], minLength: Int = 3) -> [String] {
        var possibleWords: [String] = []
        
        for word in dictionary {
            if word.count >= minLength && canFormWord(word, with: letters) {
                possibleWords.append(word)
            }
        }
        
        // Ordenar por longitud (más largas primero)
        return possibleWords.sorted { $0.count > $1.count }
    }
    
    /// Verifica si una palabra puede formarse con las letras disponibles
    private func canFormWord(_ word: String, with letters: [String]) -> Bool {
        var availableLetters = letters.map { $0.uppercased() }
        
        for char in word {
            let letter = String(char)
            if let index = availableLetters.firstIndex(of: letter) {
                availableLetters.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// Obtiene el tamaño del diccionario
    var wordCount: Int {
        return dictionary.count
    }
}
