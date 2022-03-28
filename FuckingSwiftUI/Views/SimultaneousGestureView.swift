//
//  SimultaneousGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/28.
//

import SwiftUI

struct SimultaneousGestureView: View {
    @State private var finalScale = 1.0
    @State private var currentScale = 0.0
    
    
    @State private var finalAngle: Angle = .zero
    @State private var currentAngle: Angle = .zero
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        Image("icon")
            .resizable()
            .frame(width: 300, height: 300)
            .scaleEffect(finalScale + currentScale)
            .rotationEffect(finalAngle + currentAngle)
            .offset(offset)
            .gesture(SimultaneousGesture(scaleGesture, rotationGesture))
            .simultaneousGesture(dragGesture)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    offset = value.translation
                }
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
    }
    
    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                currentScale = value - 1
            }
            .onEnded { _ in
                finalScale += currentScale
                currentScale = 0
            }
    }
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { value in
                currentAngle = value
            }
            .onEnded { _ in
                finalAngle += currentAngle
                currentAngle = .zero
            }
    }
}

struct SimultaneousGestureView_Previews: PreviewProvider {
    static var previews: some View {
        SimultaneousGestureView()
    }
}
