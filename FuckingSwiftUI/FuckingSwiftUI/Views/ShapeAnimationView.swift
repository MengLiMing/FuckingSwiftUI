//
//  ShapeAnimationView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct ShapeAnimationView: View {
    @State private var animation = false
    @State private var slides = 3.0
    
    var body: some View {
        VStack {
            AnimationShape(sides: animation ? 30 : 0)
                .stroke(.blue, lineWidth: 3)
                .onAppear {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: true)) {
                        animation = true
                    }
                }
            
            AnimationShape(sides: slides)
                .fill(
                    LinearGradient(colors: [.red, .blue], startPoint: .topTrailing, endPoint: .bottomLeading)
                )

            Slider(value: $slides.animation(.default), in: 0...30)
        }
        .padding()
    }
}

struct ShapeAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeAnimationView()
    }
}

struct AnimationShape: Shape {
    var sides: Double
    
    var animatableData: Double {
        get { sides }
        set { sides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = min(rect.size.width/2, rect.size.height/2)
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        
        let extra = sides != Double(Int(sides)) ? 1 : 0
        
        for i in 0..<Int(sides) + extra {
            let radians = CGFloat(Angle(degrees: 360 * Double(i) / sides).radians)
            
            let point = CGPoint(
                x: center.x + radius * cos(radians),
                y: center.y + radius * sin(radians)
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}
