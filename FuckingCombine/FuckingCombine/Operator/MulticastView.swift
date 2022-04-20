//
//  MulticastView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

struct MulticastView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            Text("\(viewModel.count1)")
            Button("Test") {
                viewModel.test()
            }
        }
    }
}

extension MulticastView {
    final class ViewModel: ObservableObject {
        @Published private(set) var count: Int = 0
        @Published private(set) var count1: Int = 0
        
        private var cancelBag: Set<AnyCancellable> = []
        func test() {
            let subject = PassthroughSubject<Int, Never>()

            let publisher = Deferred {
                Future<Int, Never> { promise in
                    print("请求")
                    request(failure: false) { _ in
                        promise(.success(Int.random(in: 0...100)))
                    }
                }
            }
                .receive(on: DispatchQueue.main)
                .print("p")
                .makeConnectable()
//                .multicast(subject: subject)

            publisher
                .print("count")
                .assign(to: \.count, on: self)
                .store(in: &cancelBag)

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                publisher
                    .print("count1")
                    .assign(to: \.count1, on: self)
                    .store(in: &self.cancelBag)
            }

            subject
                .print("subject")
                .sink { _ in }
                .store(in: &cancelBag)

            /// 使用上和share有稍微的差别 是可以控制请求的时机
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                publisher.connect()
                    .store(in: &self.cancelBag)
            }
        }
    }
}

struct Post: Codable {
    
}

struct MulticastView_Previews: PreviewProvider {
    static var previews: some View {
        MulticastView()
    }
}
