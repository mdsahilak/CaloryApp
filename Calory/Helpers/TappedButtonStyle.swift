//
//  TappedButtonStyle.swift
//  Calory
//
//  Created by Sahil Ak on 13/05/24.
//

import SwiftUI

struct TappedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                Color(uiColor: .systemOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .opacity(configuration.isPressed ? 1 : 0.01)
            )
    }
}
