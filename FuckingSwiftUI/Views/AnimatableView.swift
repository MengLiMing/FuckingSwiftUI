//
//  AnimatableView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct AnimatableView: View {
    @State private var pct: Double = 0
    
    var body: some View {
        VStack {
            Text("Fucking SwiftUI")
                .font(.largeTitle)
                .foregroundColor(from: .blue, to: .red, pct: pct)
            
            Slider(value: $pct, in: 0...1)
        }
        .padding()
    }
}

struct AnimatableView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableView()
    }
}

extension View {
    func foregroundColor(from: UIColor, to: UIColor, pct: Double) -> some View {
        modifier(AnimatableModifierView(from: from, to: to, pct: pct))
    }
}

struct AnimatableModifierView: Animatable, ViewModifier {
    let from: UIColor
    let to: UIColor
    
    var pct: Double
    
    var animatableData: Double {
        set { pct = newValue }
        get { pct }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color(from, to, pct: pct))
    }
    
    func color(_ from: UIColor, _ to: UIColor, pct: Double) -> Color {
        
        guard let fromComponents = from.cgColor.components,
                let toComponents = to.cgColor.components else { return Color(from) }
        
        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * pct
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * pct
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * pct
        
        return Color(red: r, green: g, blue: b)
    }
}
