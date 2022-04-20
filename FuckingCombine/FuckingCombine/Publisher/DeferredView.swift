//
//  DeferredView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

struct DeferredView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("数组个数 \(viewModel.count)")
            
            Button("Test Future") {
                viewModel.testFuture()
            }
            
            Button("Test Deferred Future") {
                viewModel.testDeferred()
            }
        }
    }
}

extension DeferredView {
    final class ViewModel: ObservableObject {
        @Published var count: Int = 0
        
        func testFuture() {
            let publisher = Future<Int, Never> { promise in
                promise(.success((0...10000000).map { $0 }.count))
            }
            
            publisher
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .assign(to: &$count)
        }
        
        func testDeferred() {
           let publisher = Deferred {
                Future<Int, Never> { promise in
                    promise(.success((0...10000000).map { $0 }.count))
                }
            }
            
            publisher
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .assign(to: &$count)
        }
    }
}

struct DeferredView_Previews: PreviewProvider {
    static var previews: some View {
        DeferredView()
    }
}
