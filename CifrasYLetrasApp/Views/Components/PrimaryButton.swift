//
//  PrimaryButton.swift
//  CifrasYLetrasApp
//
//  Botón principal reutilizable
//

import SwiftUI

/// Botón principal estilizado de la aplicación
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    
    enum ButtonStyle {
        case primary
        case secondary
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(style == .primary ? .white : Color("PrimaryColor"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    style == .primary ?
                        Color("PrimaryColor") :
                        Color.white
                )
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style == .secondary ? Color.gray.opacity(0.3) : Color.clear, lineWidth: 1)
                )
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            PrimaryButton(title: "Botón Principal", action: {}, style: .primary)
            PrimaryButton(title: "Botón Secundario", action: {}, style: .secondary)
        }
        .padding()
    }
}
