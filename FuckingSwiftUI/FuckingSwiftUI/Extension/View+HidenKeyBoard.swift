//
//  View+HidenKeyBoard.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
