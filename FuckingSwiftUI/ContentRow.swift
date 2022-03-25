//
//  ContentPageRow.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct ContentRow: View {
    let title: String
    let subTitle: String?
    
    init(title: String, subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            if subTitle != nil {
                Text(subTitle!)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
        }
    }
}

struct ContentPageRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(title: "测试", subTitle: "测试")
            .previewLayout(.sizeThatFits)
    }
}
