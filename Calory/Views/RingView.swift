//
//  RingView.swift
//  Calory
//
//  Created by Sahil Ak on 13/05/24.
//

import SwiftUI

struct RingView: View {
    var currentValue: Double
    var totalValue: Double
    
    var lineWidth: CGFloat = 11
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.accent.opacity(0.3))
            
            Circle()
                .trim(from: getTrim(), to: 1)
                .stroke(.accent, style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
        }
    }
    
    private func getTrim() -> Double {
        let r = currentValue / totalValue
        let trim = 1 - r
        
        return trim
    }
}

#Preview {
    RingView(currentValue: 0.7, totalValue: 1.0)
}
