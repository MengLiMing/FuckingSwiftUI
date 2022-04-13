//
//  VStackView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct VStackView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Rectangle()
                    .fill(.red)
                    .frame(width: 100)
                
                Divider()
                
                Rectangle()
                    .fill(.green)
                    .frame(width: 100)
                
                Divider()
                
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100)
                
                Spacer()
            }
            .frame(maxWidth: 150)
            .border(.red, width: 1)
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    ForEach(0..<10000) { index in
                        Rectangle()
                            .fill(Color.random)
                            .frame(width: CGFloat.random(in: 100...200))
                    }
                }
            }
            .border(.blue, width: 1)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VStack + LazyVStack")
    }
}

struct VStackView_Previews: PreviewProvider {
    static var previews: some View {
        VStackView()
    }
}
