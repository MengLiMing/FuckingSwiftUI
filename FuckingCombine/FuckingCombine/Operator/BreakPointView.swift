//
//  BreakPointView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/25.
//

import SwiftUI
import Combine

struct BreakPointView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("-") {
                    viewModel.reduce()
                }
                Text("\(viewModel.count)")
                Button("+") {
                    viewModel.add()
                }
            }
        }
    }
}

extension BreakPointView {
    final class ViewModel: ObservableObject {
        @Published var count: Int = 0
        
        private var cancelBag: Set<AnyCancellable> = []
        
        init() {
            $count.breakpoint { s in
                return true
            } receiveOutput: { value in
                return value == 3
            }
            .sink { _ in }
            .store(in: &cancelBag)
        }
        
        func add() {
            count += 1
        }
        
        func reduce() {
            count -= 1
        }
    }
}

struct BreakPointView_Previews: PreviewProvider {
    static var previews: some View {
        BreakPointView()
    }
}
