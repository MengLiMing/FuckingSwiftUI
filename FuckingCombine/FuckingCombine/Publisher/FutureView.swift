//
//  FutureView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

struct FutureView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        HStack {
            Button {
                viewModel.action(.reduce)
            } label: {
                Image(systemName: "minus.square.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            Text(String(viewModel.count))
                .padding(.horizontal, 10)
            
            Button {
                viewModel.action(.add)
            } label: {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .buttonStyle(.plain)
    }
}

extension FutureView {
    final class ViewModel: ObservableObject {
        @Published private(set) var count: Int = 0
        
        private lazy var actionPublisher = Future<Int, Never> { [weak self] promise in
            guard let self = self else {
                return
            }

        }
        
        enum Action {
            case add
            case reduce
        }
        
        /// 此处只是为了使用而是用。。
        func publisher(_ action: Action) -> AnyPublisher<Int, Never> {
            Future<Int, Never> { promise in
                switch action {
                case .add:
                    promise(.success(self.count + 1))
                case .reduce:
                    promise(.success(self.count - 1))
                }
            }
            .eraseToAnyPublisher()
        }
        
        func action(_ action: Action) {
            publisher(action)
                .assign(to: &$count)
        }
    }
}

struct FutureView_Previews: PreviewProvider {
    static var previews: some View {
        FutureView()
    }
}
