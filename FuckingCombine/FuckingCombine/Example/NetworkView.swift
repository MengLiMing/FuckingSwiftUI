//
//  NetworkView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import SwiftUI
import Combine

struct NetworkView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let result = viewModel.result {
                Text("请求结果: " + "\(result)")
            }
            
            Button("点击请求 - map - switchToLatest") {
                viewModel.request()
            }
        }
    }
}

extension NetworkView {
    final class ViewModel: ObservableObject {
        @Published private(set) var isLoading = false
        
        @Published private(set) var result: Bool?
        
        private let publisher = PassthroughSubject<Void, Never>()
        
        init() {
            publisher
                .flatMapLatest { _ in
                    postmanTimeCheck(date: .now)
                        .print()
                }
                .map { $0.valid }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: &$result)
            
            Publishers.Merge(
                publisher.map { true },
                $result.map { _ in false }
            )
            .assign(to: &$isLoading)
        }
        
        func request() {
            publisher.send(())
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
