//
//  TapGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct TapGestureView: View {
    @State private var counter = 1
    var body: some View {
        VStack {
            Text("单击\(counter)")
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .gesture(
                    TapGesture(count: 1)
                        .onEnded() {
                            counter += 1
                        }
                )
            
            Text("双击\(counter)")
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .onTapGesture(count: 2, perform: { counter += 1 })
        }
    }
}

struct TapGestureView_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureView()
    }
}
