//
//  View+Tool.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

public extension View {
    func currentSize(_ size: Binding<CGSize?>) -> some View {
        overlay(
                GeometryReader { geo in
                    Color.clear
                        .doSomeThing {
                            DispatchQueue.main.async {
                                size.wrappedValue = geo.size
                            }
                        }
                }
            )
    }
    
    func doSomeThing(_ block: () -> Void) -> some View {
        block()
        return self
    }
}
