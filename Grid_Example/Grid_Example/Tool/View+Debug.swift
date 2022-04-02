//
//  View+Debug.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/1.
//

import SwiftUI


extension View {
    func measured(_ color: Color) -> some View {
        overlay(GeometryReader { geo in
            HStack(spacing: 2) {
                Arrow()
                Text("\(geo.size.width, specifier: "%.2f")")
                    .font(.system(size: 14)).bold()
                    .foregroundColor(color)
                    .fixedSize()
                    .frame(maxHeight: .infinity)
                Arrow()
                    .scaleEffect(-1, anchor: .center)
            }
        })
    }
    
    var measured: some View {
        measured(.white)
    }
    
    var measuredBelow: some View {
        padding(.bottom, 25)
        .overlay(Color.clear.frame(height: 25).measured(.black), alignment: .bottom)
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let x = rect.minX + 2
            let size = 5.0
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: x + size, y: rect.midY - size))
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: x + size, y: rect.midY + size))
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}

struct Arrow: View {
    var body: some View {
        ArrowShape()
            .stroke(lineWidth: 1)
            .foregroundColor(Color(red: 9/255.0, green: 73/255.0, blue: 109/255.0))
    }
}
