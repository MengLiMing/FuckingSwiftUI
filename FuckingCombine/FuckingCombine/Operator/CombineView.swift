//
//  CombineView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/25.
//

import SwiftUI
import Combine

struct CombineView: View {
    @State private var cancelBag: Set<AnyCancellable> = []
    
    var body: some View {
        VStack {
            Button("combineLatest") {
                testCombineLatest()
            }
            Button("merge") {
                testMerge()
            }
            Button("zip") {
                testZip()
            }
        }
    }
    
    func testCombineLatest() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        
        publisher2.send("A")
        publisher1.combineLatest(publisher2)
            .sink { (v1, v2) in
                print("(\(v1), \(v2))")
            }
            .store(in: &cancelBag)
        publisher1.send(1)
        publisher2.send("B")
        publisher1.send(2)
    }
    
    func testMerge() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Int, Never>()
        
        publisher2.send(101)
        publisher1.merge(with: publisher2)
            .sink { value in
                print(value)
            }
            .store(in: &cancelBag)
        
        publisher1.send(1)
        publisher2.send(102)
        publisher1.send(2)
    }
    
    func testZip() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        publisher2.send("A")
        publisher1.zip(publisher2)
            .sink { (v1, v2) in
                print("(\(v1), \(v2))")
            }
            .store(in: &cancelBag)
        publisher1.send(1)
        publisher2.send("B")
        publisher1.send(2)
        publisher2.send("C")
        publisher1.send(3)
        publisher1.send(4)
        publisher1.send(5)
        publisher2.send("D")
        publisher2.send("E")
        publisher2.send("F")

    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
