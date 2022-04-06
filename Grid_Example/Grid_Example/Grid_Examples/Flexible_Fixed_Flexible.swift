//
//  Flexible_Fixed_Flexible.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

struct Flexible_Fixed_Flexible: View {
    let items1 = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.fixed(100)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 30))
    ]
    
    let items2 = [
        GridItem(.flexible(minimum: 30)),
        GridItem(.fixed(50)),
        GridItem(.adaptive(minimum: 30))
    ]
    
    @State private var width1: CGFloat = 0
    
    @State private var width2: CGFloat = 0

    var body: some View {
        VStack {
//            LazyVGrid(columns: items1) {
//                items(4)
//            }
//            .widthChangeable($width1)
//            
//            drawResult(items1, contentWidth: width1)
            
            LazyVGrid(columns: items2) {
                items(10)
            }
            .widthChangeable($width2)
            
            drawResult(items2, contentWidth: width2)
        }
    }
    
    func drawResult(_ items: [GridItem], contentWidth: CGFloat) -> some View {
        let result = draw(items, contentWidth: contentWidth)
        return HStack {
            ForEach(result.flatMap { $0 }, id: \.self) { value in
                Text("\(value, specifier: "%.2f")")
            }
        }
    }
}

struct Flexible_Fixed_Flexible_Previews: PreviewProvider {
    static var previews: some View {
        Flexible_Fixed_Flexible()
            .previewInterfaceOrientation(.portrait)
    }
}
