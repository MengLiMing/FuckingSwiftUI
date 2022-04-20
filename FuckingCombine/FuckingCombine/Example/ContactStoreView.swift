//
//  ContactStoreView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import SwiftUI
import Contacts
import Combine

struct ContactStoreView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.authorized {
                Text("已经获取权限")
            } else {
                Button("请求权限") {
                    viewModel.request()
                }
            }
        }
        .alert("设置打开权限", isPresented: $viewModel.showRequestAuth) {
            Button("Open Setting") {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
    }
}

extension ContactStoreView {
    final class ViewModel: ObservableObject {
        @Published private(set) var authorized: Bool = false
        
        @Published private(set) var notDetermined: Bool = false
        
        private let requestAuth = PassthroughSubject<Void, Never>()
        
        private var cancelBag: Set<AnyCancellable> = []
        
        @Published var showRequestAuth = false
        
        init() {
            requestAuth
                .flatMapLatest { _ in
                    Future<Bool, Error> { promise in
                        CNContactStore().requestAccess(for: .contacts) { result, error in
                            if let error = error {
                                promise(.failure(error))
                            } else {
                                promise(.success(result))
                            }
                        }
                    }
                }
                .map { _ in }
                .replaceError(with: ())
                .merge(with: Just(()))
                .flatMapLatest {
                    Future<CNAuthorizationStatus, Never> { promise in
                        promise(.success(CNContactStore.authorizationStatus(for: .contacts)))
                    }
                }
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [unowned self] status in
                    authorized = status == .authorized
                    notDetermined = status == .notDetermined
                })
                .store(in: &cancelBag)
        }

        func request() {
            if notDetermined {
                requestAuth.send(())
            } else if authorized == false {
               showRequestAuth = true
            }
        }
    }
}

struct ContactStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ContactStoreView()
    }
}
