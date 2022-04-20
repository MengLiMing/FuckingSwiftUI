//
//  ShareView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

struct ShareView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count1)")
            Text("\(viewModel.count2)")

            Button("Test") {
                viewModel.test()
            }
            
            Button("Test Share") {
                viewModel.testShare()
            }
        }
    }
}

extension ShareView {
    final class ViewModel: ObservableObject {
        @Published private(set) var count1 = 0
        @Published private(set) var count2 = 0

        private var cancelBag: Set<AnyCancellable> = []
        
        func test() {
            cancelBag.removeAll()

            let publisher = Deferred {
                Future<Int, Never> { promise in
                    print("请求...")
                    request(failure: false) { _ in
                        promise(.success(Int.random(in: 0...100)))
                    }
                }
            }
            
            publisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.count1, on: self)
                .store(in: &cancelBag)
            
            publisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.count2, on: self)
                .store(in: &cancelBag)
        }
        
        func testShare() {
            cancelBag.removeAll()
            
            let publisher = Deferred {
                Future<Int, Never> { promise in
                    print("请求...")
                    request(failure: false) { _ in
                        promise(.success(-Int.random(in: 0...100)))
                    }
                }
            }
                .eraseToAnyPublisher()
                .share()
            
            publisher
                .print("count1")
                .receive(on: DispatchQueue.main)
                .assign(to: \.count1, on: self)
                .store(in: &cancelBag)
            
            /// 只能订阅到完成事件
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                publisher
                    .print("count2")
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.count2, on: self)
                    .store(in: &self.cancelBag)
            }
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
