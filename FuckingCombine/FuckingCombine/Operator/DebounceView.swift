//
//  DebounceView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/25.
//

import SwiftUI

struct DebounceView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(viewModel.result)
        }
    }
}

extension DebounceView {
    final class ViewModel: ObservableObject {
        @Published var text: String = ""
        
        @Published var result: String = ""
        
        init() {
            $text
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .print()
                .scan("") { $0 + $1 + "\n" }
                .assign(to: &$result)
        }
    }
}

struct DebounceView_Previews: PreviewProvider {
    static var previews: some View {
        DebounceView()
    }
}
