//
//  Grid+Tool.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/1.
//

import SwiftUI

func items(_ count: Int) -> some View {
    ForEach(Array(0..<count), id: \.self) { idx in
        Rectangle()
            .fill(.blue)
            .frame(height: 50)
            .measured
    }
}
