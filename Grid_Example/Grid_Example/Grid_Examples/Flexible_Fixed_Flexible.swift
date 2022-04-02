//
//  Flexible_Fixed_Flexible.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

struct Flexible_Fixed_Flexible: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 180)),
                GridItem(.fixed(100)),
                GridItem(.flexible(minimum: 100))
            ]) {
                items(4)
            }
            .widthChangeable
            
            
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100)),
                GridItem(.fixed(100)),
                GridItem(.flexible(minimum: 180))
            ]) {
                items(4)
            }
            .widthChangeable
        }
    }
}

struct Flexible_Fixed_Flexible_Previews: PreviewProvider {
    static var previews: some View {
        Flexible_Fixed_Flexible()
            .previewInterfaceOrientation(.portrait)
    }
}
