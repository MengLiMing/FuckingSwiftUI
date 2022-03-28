//
//  MagnificationGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct MagnificationGestureView: View {
    @State private var finalScale = 1.0
    @State private var currentScale = 0.0
    
    var body: some View {
        Image("icon")
            .resizable()
            .scaledToFit()
            .scaleEffect(finalScale + currentScale)
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.1)
                    .onChanged { value in
                        currentScale = value - 1
                    }
                    .onEnded { _ in
                        finalScale += currentScale
                        currentScale = 0
                    }
            )
    }
}

struct MagnificationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureView()
    }
}
