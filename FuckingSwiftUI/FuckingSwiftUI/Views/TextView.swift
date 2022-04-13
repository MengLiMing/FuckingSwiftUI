//
//  TextView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct TextView: View {
    let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateStyle = .long
        return format
    }()
    
    var body: some View {
        VStack {
            Text("Hello")
                .bold()
                .italic()
                .underline()
            
            Text("Fucking SwiftUI")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
                .lineLimit(2)
                .frame(width: 100, alignment: .center)
            
            Text("What time is it?: \(Date.now, formatter: dateFormatter)")
            
            Link("MengLiMing", destination: URL(string: "https://github.com/MengLiMing")!)
            
            Group {
                Text("Hello")
                    .foregroundColor(.blue)
                +
                Text("World")
                    .foregroundColor(.red)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Text")
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
