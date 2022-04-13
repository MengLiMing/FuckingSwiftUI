//
//  RotationGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/28.
//

import SwiftUI

struct RotationGestureView: View {
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(0)

    var body: some View {
        Image("icon")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .rotationEffect(currentAngle + finalAngle)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.currentAngle = angle
                    }
                    .onEnded { angle in
                        self.finalAngle += self.currentAngle
                        self.currentAngle = .degrees(0)
                    }
            )
    }
}

struct RotationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
