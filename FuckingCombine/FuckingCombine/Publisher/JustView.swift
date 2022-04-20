//
//  JustView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

struct JustView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(viewModel.random)")
            
            Button("Test") {
                viewModel.test()
            }
            
            Text(viewModel.mapContent)
            Button("Map") {
                viewModel.testMap()
            }
        }
    }
}

extension JustView {
    final class ViewModel: ObservableObject {
        @Published private(set) var random: Int = 0
        
        @Published private(set) var mapContent: String = "Nothing"

        private var cancelBag: Set<AnyCancellable> = []
        
        func test() {
            Just(Int.random(in: 0...100))
                .print()
                .removeDuplicates()
                .assign(to: &$random)
        }
        
        func testMap() {
            Just(Int.random(in: -3...5))
                .map { value in
                    switch value {
                    case _ where value < 1:
                        return "none"
                    case _ where value == 1:
                        return "one"
                    case _ where value == 2:
                        return "two"
                    case _ where value == 3:
                        return "three"
                    default:
                        return "some"
                    }
                }
                .assign(to: \.mapContent, on: self)
                .store(in: &cancelBag)
        }
    }
}

struct JustView_Previews: PreviewProvider {
    static var previews: some View {
        JustView()
    }
}

