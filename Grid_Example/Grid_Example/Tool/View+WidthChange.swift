//
//  View+WidthChange.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

extension View {
    var widthChangeable: some View {
        WidthChangedWrapper {
            self
        }
    }
    
    func widthChangeable(_ width: Binding<CGFloat>) -> some View {
        WidthChangedWrapper(content: {
            self
        }, widthBinding: width)
    }
}

struct WidthChangedWrapper<Content: View>: View {
    @State private var width: CGFloat = 300
    
    @ViewBuilder var content: () -> Content

    let maxWidth = UIScreen.main.bounds.width
    
    var widthBinding: Binding<CGFloat>?

    var body: some View {
        VStack {
            content()
                .frame(width: width)
                .border(.black)
                .measuredBelow
            
            Slider(value: $width, in: 0...maxWidth, step: 1)
                .padding()
        }
        .onChange(of: width) { newValue in
            widthBinding?.wrappedValue = newValue
        }
        .onAppear {
            widthBinding?.wrappedValue = width
        }
    }
}
