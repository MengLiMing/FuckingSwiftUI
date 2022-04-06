//
//  Adaptive_Adaptive.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/6.
//

import SwiftUI

struct Adaptive_Adaptive: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 50, maximum: 100)),
                GridItem(.adaptive(minimum: 50, maximum: 100))
            ]) {
                items(10)
            }
            .widthChangeable
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 50, maximum: 100)),
                GridItem(.adaptive(minimum: 40, maximum: 100))
            ]) {
                items(10)
            }
            .widthChangeable
        }
    }
}

struct Adaptive_Adaptive_Previews: PreviewProvider {
    static var previews: some View {
        Adaptive_Adaptive()
    }
}
