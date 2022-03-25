//
//  View+NavigationLink.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

public extension View {
    func navigationLink<V: View>(@ViewBuilder destination: () -> V) -> NavigationLink<Self, V> {
        return NavigationLink {
            destination()
        } label: {
            self
        }
    }
}
