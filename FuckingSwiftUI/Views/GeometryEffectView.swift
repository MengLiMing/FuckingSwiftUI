//
//  GeometryEffectView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct GeometryEffectView: View {
    @State private var pct = 0.5
    @State private var animation = false
    
    @State private var flag = false
    
    let flagAnimation = Animation.easeInOut(duration: 3)
    
    var body: some View {
        VStack {
            VStack {
                Button("Button") {
                    withAnimation(flagAnimation) {
                        flag.toggle()
                    }
                }
                
                if flag {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 50, height: 100)
                        .shadow(radius: 10)
                        .transition(.myEffect.combined(with: .scale).animation(flagAnimation))
                }
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 100, height: 200)
                .shadow(radius: 10)
                .modifier(AnimationGeometryEffect(pct: animation ? 1 : 0))
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                        animation = true
                    }
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 100, height: 200)
                .shadow(radius: 10)
                .modifier(AnimationGeometryEffect(pct: pct))

            Slider(value: $pct, in: 0...1)
        }
        .padding()
    }
}

extension AnyTransition {
    static var myEffect: AnyTransition {
        .modifier(
            active: AnimationGeometryEffect(pct: 1),
            identity: AnimationGeometryEffect(pct: 0))
    }
}

struct GeometryEffectView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryEffectView()
    }
}

struct AnimationGeometryEffect: GeometryEffect {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1 / 1000
        
        transform3D = CATransform3DTranslate(transform3D, size.width/2, size.height/2, 0)
        
        transform3D = CATransform3DRotate(transform3D, Angle(degrees: 360 * pct).radians, 1, 5, 0)
        transform3D = CATransform3DRotate(transform3D, Angle(degrees: 360 * (1 - pct)).radians, 0, 0, 1)
        
        transform3D = CATransform3DTranslate(transform3D, -size.width/2, -size.height/2, 0)

        return ProjectionTransform(transform3D)
    }
}
