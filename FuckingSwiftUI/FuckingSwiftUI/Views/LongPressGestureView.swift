//
//  LongPressGestureView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct LongPressGestureView: View {
    @State private var flag = false
    
    var body: some View {
        VStack {
            Capsule()
                .fill(flag ? .red : .blue)
                .frame(maxHeight: 60)
                .onLongPressGesture(minimumDuration: 1, maximumDistance: 30) {
                    flag.toggle()
                } onPressingChanged: { value in
                    print("pressingChanged: \(value)")
                }
            
            Capsule()
                .fill(flag ? .red : .blue)
                .frame(maxHeight: 60)
                .gesture(
                    LongPressGesture(minimumDuration: 1, maximumDistance: 30)
                        .onChanged { _ in
                            print("true")
                        }
                        .onEnded { _ in
                            print("false")
                            flag.toggle()
                        }
                )
        }
        .padding()
    }
}

struct LongPressGestureView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureView()
    }
}


