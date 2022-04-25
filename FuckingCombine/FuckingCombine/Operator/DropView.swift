//
//  DropView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/24.
//

import SwiftUI
import Combine

struct DropView: View {
    @State private var cancelBag: Set<AnyCancellable> = []
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: test)
    }
    
    func test() {
        _ = [1,2,3,4,5,6]
            .publisher
            .dropFirst()
            .sink { print($0) }
        
        print("----dropWhile-----")
        
        /// dropWhile 忽略上有发布者的元素，直到闭包返回false
        _ = [1,2,3,4,5]
            .publisher
            .drop(while: { value in
                value == 2
            })
            .sink { print($0) }
        
        print("------------")
        
        _ = [1,2,3,4,5]
            .publisher
            .drop(while: { value in
                value <= 2
            })
            .sink { print($0) }
        
        print("-----dropUntil-------")
        
        let valueSubject = PassthroughSubject<Int, Never>()
        let dropSubject = PassthroughSubject<Void, Never>()
        
        valueSubject
            .drop(untilOutputFrom: dropSubject)
            .sink { print($0) }
            .store(in: &cancelBag)
        
        valueSubject.send(1)
        valueSubject.send(2)
        
        dropSubject.send(())
        valueSubject.send(3)
        valueSubject.send(4)
        dropSubject.send(())
        valueSubject.send(5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            dropSubject.send(())
        }
    }
}

struct DropView_Previews: PreviewProvider {
    static var previews: some View {
        DropView()
    }
}
