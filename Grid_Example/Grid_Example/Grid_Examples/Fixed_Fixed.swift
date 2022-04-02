//
//  Fixed_Fixed.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

struct Fixed_Fixed: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(60)),
            GridItem(.fixed(100))
        ]) {
            items(3)
        }
        .widthChangeable
    }
}

struct Fixed_Fixed_Previews: PreviewProvider {
    static var previews: some View {
        Fixed_Fixed()
    }
}
