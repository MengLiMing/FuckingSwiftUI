//
//  AllSatisfyView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/24.
//

import SwiftUI

struct AllSatisfyView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: test)
    }
    
    func test() {
       _ = [1,2,3,4,5]
            .publisher
            .allSatisfy { value in
                value % 2 == 0
            }
            .sink { print($0) }
        
        _ = [1,2,3,4,5]
             .publisher
             .allSatisfy { value in
                 value > 0
             }
             .sink { print($0) }
    }
}

struct AllSatisfyView_Previews: PreviewProvider {
    static var previews: some View {
        AllSatisfyView()
    }
}
