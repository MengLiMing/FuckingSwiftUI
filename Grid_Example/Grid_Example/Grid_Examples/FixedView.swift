//
//  FixedView.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/1.
//

import SwiftUI

struct FixedView: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(60))
        ]) {
            items(3)
        }
        .widthChangeable
    }
}

struct FixedView_Previews: PreviewProvider {
    static var previews: some View {
        FixedView()
    }
}


