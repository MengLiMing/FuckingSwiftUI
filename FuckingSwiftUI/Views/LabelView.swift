//
//  LabelView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct LabelView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Label("刚刚好", image: "icon")
                .frame(maxWidth: 200, maxHeight: 50)
                .clipped()
                .border(.red, width: 1)

            
            Label {
                Text("刚刚好")
            } icon: {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .border(.blue, width: 1)
            }
            .border(.red, width: 1)
            
            Label("刚刚好", systemImage: "globe")
                .border(.red, width: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Label")
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView()
    }
}
