//
//  Adaptive.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/6.
//

import SwiftUI

struct Adaptive: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 50, maximum: 100))
        ]) {
            items(10)
        }
        .widthChangeable
    }
}

struct Adaptive_Previews: PreviewProvider {
    static var previews: some View {
        Adaptive()
    }
}
