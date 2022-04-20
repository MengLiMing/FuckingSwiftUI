//
//  MeasureIntervalView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import SwiftUI
import Combine

struct MeasureIntervalView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Test") {
                viewModel.test()
            }
            
            Button("Test2") {
                viewModel.test2()
            }
            
            NavigationLink {
                Text("1")
            } label: {
                Text("push")
            }
        }
    }
}

extension MeasureIntervalView {
    final class ViewModel: ObservableObject {
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        private var cancelBag: Set<AnyCancellable> = []
        
        func test() {
            cancelBag.removeAll()

            timer
                .measureInterval(using: DispatchQueue.global(qos: .background))
                .sink(receiveValue: { value in
                    if case .nanoseconds(let nanoseconds) = value.timeInterval {
                        print(Double(nanoseconds)/1000000000)
                    }
                })
                .store(in: &cancelBag)
        }
        
        func test2() {
            cancelBag.removeAll()
            
            let foo = PassthroughSubject<Int, Never>()
            
            let queue = DispatchQueue.global(qos: .default)
            foo
                .measureInterval(using: queue)
                .sink(receiveValue: { value in
                    if case .nanoseconds(let nanoseconds) = value.timeInterval {
                        print("间隔：\(Double(nanoseconds)/1000000000)")
                    }
                })
                .store(in: &cancelBag)
            
            queue.asyncAfter(deadline: .now() + 0.1) {
                foo.send(1)
            }
            
            queue.asyncAfter(deadline: .now() + 0.2) {
                foo.send(2)
            }
            
            queue.asyncAfter(deadline: .now() + 1.1) {
                foo.send(3)
            }
            
            queue.asyncAfter(deadline: .now() + 1.3) {
                foo.send(4)
            }
            
            queue.asyncAfter(deadline: .now() + 1.31) {
                foo.send(5)
            }
        }
    }
}

struct MeasureIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureIntervalView()
    }
}
