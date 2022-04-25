//
//  PrependView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/24.
//

import SwiftUI
import Combine

struct PrependView: View {
    @State private var cancelBag: Set<AnyCancellable> = []
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: test)
    }
    
    func test() {
        let firstSubject = PassthroughSubject<Int, Never>()
        let secondSubject = PassthroughSubject<Int, Never>()
        
        firstSubject
            .prepend(secondSubject)
            .sink { value in
                print(value)
            }
            .store(in: &cancelBag)
        
        firstSubject.send(1)
        firstSubject.send(2)

        secondSubject.send(100)
        secondSubject.send(101)
        
        firstSubject.send(3)
        secondSubject.send(103)
        
        secondSubject.send(completion: .finished)
        
        firstSubject.send(4)
     
//        输出
//        100
//        101
//        103
//        4
    }
}

struct PrependView_Previews: PreviewProvider {
    static var previews: some View {
        PrependView()
    }
}
