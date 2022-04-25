//
//  ThrottleView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/25.
//

import SwiftUI
import Combine

struct ThrottleView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(viewModel.result)
            
            Toggle("Latest", isOn: $viewModel.latest)
        }
    }
}

extension ThrottleView {
    final class ViewModel: ObservableObject {
        @Published var text: String = ""
        
        @Published var result: String = ""
        
        @Published var latest: Bool = false
        
        private var cancelBag: Set<AnyCancellable> = []
        
        init() {
            $latest
                .removeDuplicates()
                .sink {[unowned self] _ in
                    self.reset()
                }
                .store(in: &cancelBag)
            
            $latest
                .flatMapLatest { [unowned self] value in
                    $text
                        .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: value)
                }
                .assign(to: &$result)
        }
        
        func reset() {
            text = ""
        }
    }
}

struct ThrottleView_Previews: PreviewProvider {
    static var previews: some View {
        ThrottleView()
    }
}
