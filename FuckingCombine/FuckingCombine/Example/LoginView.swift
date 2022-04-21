//
//  LoginView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            EditView(systemName: "iphone.circle", hint: "请输入手机号", text: $viewModel.phone)
            
            EditView(systemName: "lock.circle", hint: "请输入密码", text: $viewModel.pwd)
            
            EditView(systemName: "lock.circle", hint: "再次确认密码", text: $viewModel.confirmPwd)
            
            Button("登录") {
                viewModel.login()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
            .disabled(!viewModel.isValidated)
            
            Spacer()
        }
    }
}

extension LoginView {
    struct EditView: View {
        let systemName: String
        
        let hint: String
        
        @Binding var text: String
        
        var body: some View {
            Group {
                HStack {
                    Image(systemName: systemName)
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                    TextField(hint, text: $text)
                        .textFieldStyle(.plain)
                        .frame(height: 40)
                        .font(.system(size: 13))
                }
                .padding(.horizontal)

                Divider()
                    .padding(.horizontal)
            }
        }
    }
}

extension LoginView {
    final class ViewModel: ObservableObject {
        @Published var phone: String = ""
        @Published var pwd: String = ""
        @Published var confirmPwd: String = ""
        
        @Published var isValidated: Bool = false
        
        init() {
            Publishers.CombineLatest(
                $phone.map { $0.count == 11 },
                $pwd.combineLatest($confirmPwd).map {
                    $0.0.count >= 8 && $0.0 == $0.1
                }
            )
            .map { $0.0 && $0.1 }
            .replaceError(with: false)
            .assign(to: &$isValidated)
            
        }
        
        func login() {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
