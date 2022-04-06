//
//  Flexible_Fixed_Adaptive_Fixed.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/6.
//

import SwiftUI

struct Flexible_Fixed_Adaptive_Fixed: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100)),
                GridItem(.fixed(100)),
                GridItem(.adaptive(minimum: 0), spacing: 0),
                GridItem(.fixed(100)),
            ]) {
                items(10)
            }
            .widthChangeable
        }
    }
}

struct Flexible_Fixed_Adaptive_Fixed_Previews: PreviewProvider {
    static var previews: some View {
        Flexible_Fixed_Adaptive_Fixed()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
