//
//  CollectView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/24.
//

import SwiftUI
import Combine

struct CollectView: View {
    @State private var cancelBag: Set<AnyCancellable> = []
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: test)
    }
    
    func test() {
        [1,2,3,4,5,6,7]
            .publisher
            .collect(2)
            .sink { value in
                print(value)
            }
            .store(in: &cancelBag)
        
        let publisher1 = PassthroughSubject<Int, Never>()
        
        publisher1
            .collect(3)
            .sink { value in
                print(value)
            }
            .store(in: &cancelBag)
        
        publisher1.send(1)
        publisher1.send(1)
        publisher1.send(1)
        
        publisher1.send(2)
        
        publisher1.send(completion: .finished)
        
        let publisher2 = PassthroughSubject<String, Never>()
        
        publisher2.collect(.byTimeOrCount(DispatchQueue.main, .seconds(2), 2))
            .sink { value in
                print(value)
            }
            .store(in: &cancelBag)
        
        publisher2.send("A")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            publisher2.send("B")
            
            publisher2.send("B")
            
            publisher2.send("C")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                publisher2.send("C")
                
                publisher2.send("D")
                
                publisher2.send(completion: .finished)
            }
        }
    }
}

struct CollectView_Previews: PreviewProvider {
    static var previews: some View {
        CollectView()
    }
}
