//
//  DragGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/28.
//

import SwiftUI

struct DragGestureView: View {
    
    @State private var tapLocation: CGPoint = .zero
    
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            singleTap
            
            drag
        }
    }
    
    var drag: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.green)
            .frame(width: 200, height: 200)
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            dragOffset = value.translation
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragOffset = .zero
                        }
                    }
            )

    }
    
    var singleTap: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.blue)
            .frame(width: 200, height: 200)
            .overlay(
                Text(tapLocation.debugDescription)
                    .foregroundColor(.white)
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        tapLocation = value.location
                    })
                    .onEnded({ value in
                        tapLocation = value.location
                    })
            )
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
