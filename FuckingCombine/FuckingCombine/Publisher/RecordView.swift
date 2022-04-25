//
//  RecordView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/21.
//

import SwiftUI
import Combine

struct RecordView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.content + "_")
                .padding()
                .animation(.default, value: viewModel.content)
        
            
            Button("Playback") {
                viewModel.plackback()
            }
        }
    }
}

extension RecordView {
    final class ViewModel: ObservableObject {
        private var recoding: Record<String, Never>.Recording = .init()
        
        @Published var content: String = ""
        
        init() {
            "A publisher that allows for recording a series of inputs and a completion, for later playback to each subscriber.".forEach {
                recoding.receive(String($0))
            }
            recoding.receive(completion: .finished)
        }
        
        func plackback() {
            content = ""
            Record(recording: recoding)
                .reduce([], { result, value -> [(RunLoop.SchedulerTimeType.Stride, String)] in
                    var result = result
                    result.append((.milliseconds(result.count * 200), value))
                    return result
                })
                .flatMap { $0.publisher }
                .flatMap { Just($0.1).delay(for: $0.0, scheduler: RunLoop.main) }
                .withLatestFrom($content) { $1 + $0 }
                .assign(to: &$content)

        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
