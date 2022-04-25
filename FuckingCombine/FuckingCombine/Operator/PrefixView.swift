//
//  PrefixView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/25.
//

import SwiftUI
import Combine

struct PrefixView: View {
    @State private var cancelBag: Set<AnyCancellable> = []
    
    var body: some View {
        Button("Test") {
            test()
        }
    }
    
    func test() {
        _ = [1,2,3,4,5,6]
            .publisher
            .prefix(3)
            .sink { print($0) }
        
        print("--------prefix-----------")
        /// 遇到第一个false，之前满足条件的元素
        _ = [1,2,3,4,5,6]
            .publisher
            .prefix { value in
                value <= 2
            }
            .sink { print($0) }
        
        _ = [1,2,3,4,5,6]
            .publisher
            .prefix { value in
                value == 2
            }
            .sink { print($0) }
        
        print("--------prefix untilOutputFrom-----------")

        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Void, Never>()
        
        publisher1
            .prefix(untilOutputFrom: publisher2)
            .sink { print($0) }
            .store(in: &cancelBag)
        
        publisher1.send(1)
        publisher1.send(2)
        publisher1.send(3)

        publisher2.send(())
        
        publisher1.send(4)
    }
}

struct PrefixView_Previews: PreviewProvider {
    static var previews: some View {
        PrefixView()
    }
}
