//
//  VignetteView.swift
//  Shady
//
//  Created by Eli J on 12/23/25.
//

import SwiftUI

struct VignetteModifier: ViewModifier {
    var center01: CGPoint = .init(x: 0.5, y: 0.5)
    var radius: CGFloat = 0.45
    var feather: CGFloat = 0.06
    
    func body(content: Content) -> some View {
        content
            .visualEffect { content, proxy in
                content.colorEffect(
                    ShaderLibrary.vignette(
                        .float2(Float(proxy.size.width), Float(proxy.size.height)),
                        .float2(Float(center01.x), Float(center01.y)),
                        .float(Float(radius)),
                        .float(Float(feather))
                    )
                )
            }
    }
}

extension View {
    func vignette(center01: CGPoint = .init(x: 0.5, y: 0.5),
                  radius: CGFloat = 0.45,
                  feather: CGFloat = 0.06) -> some View {
        modifier(VignetteModifier(center01: center01, radius: radius, feather: feather))
    }
}

struct VignetteView: View {
    var body: some View {
        Image("Gluee")
            .foregroundStyle(.cyan)
            .vignette(radius: 0.2, feather: 0.7)
    }
}

#Preview {
    VignetteView()
}
