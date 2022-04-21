//
//  NotificationView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/21.
//

import SwiftUI
import Combine

struct NotificationView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.keyboardY)")
            TextField("", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            
            NavigationLink {
                NextView()
            } label: {
                Text("跳转")
            }
        }
        .onAppear {
            viewModel.viewAppear = true
        }
        .onDisappear {
            viewModel.viewAppear = false
        }
        .padding()
    }
}

extension NotificationView {
    final class ViewModel: ObservableObject {
        @Published var keyboardY: CGFloat = 0
        
        @Published var viewAppear: Bool = false
        
        
        init() {
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                 .compactMap {
                     $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                 }
                 .map { $0.minY }
                 .print("Nothing")
                 .receive(on: DispatchQueue.main)
                 .assign(to: &$keyboardY)
            
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                 .compactMap {
                     $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                 }
                 .withLatestFrom($viewAppear) { ($0, $1) }
                 .filter { $0.1 }
                 .map { $0.0.minY }
                 .print("withLatestFrom")
                 .receive(on: DispatchQueue.main)
                 .assign(to: &$keyboardY)
        }
    }
}

extension NotificationView {
    fileprivate struct NextView: View {
        var body: some View {
            TextField("文字", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
