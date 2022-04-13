//
//  HStackView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct HStackView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Rectangle()
                    .fill(.red)
                    .frame(height: 200)
                
                Divider()
                
                Rectangle()
                    .fill(.green)
                    .frame(height: 200)
                
                Divider()
                
                Rectangle()
                    .fill(.blue)
                    .frame(height: 200)
                
                Spacer()
            }
            .frame(maxHeight: 250)
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    Section {
                        ForEach(0..<10000) { index in
                            Rectangle()
                                .fill(Color.random)
                                .frame(height: CGFloat.random(in: 100...200))
                                .id(index)
                        }
                    } header: {
                        Text("header")
                    } footer: {
                        Text("Footer")
                    }
                }
            }
            .frame(height: 250)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("HStack + LazyHStack")
    }
}



struct HStackView_Previews: PreviewProvider {
    static var previews: some View {
        HStackView()
    }
}
