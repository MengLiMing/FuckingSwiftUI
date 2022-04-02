//
//  Flexible.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

struct Flexible: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200))
        ]) {
            items(4)
        }
        .widthChangeable
    }
}

struct Flexible_Previews: PreviewProvider {
    static var previews: some View {
        Flexible()
    }
}
