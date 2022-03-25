//
//  TextFieldView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct TextFieldView: View {
    enum Field {
        case username
        case password
        
        mutating func toggle() {
            self = self == .username ? .password : .username
        }
    }
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @FocusState private var focusState: Field?
        
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Text(username.isEmpty ? "请输入姓名" : username)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(focusState == .username ? 0 : 1)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        focusState = .username
                    }
                    .padding(.leading, 5)
                
                TextField(text: $username) {
                    Text("请输入用户名")
                }
                .textFieldStyle(.roundedBorder)
                .focused($focusState, equals: .username)
                .opacity(focusState == .username ? 1 : 0)
                .submitLabel(.next)
                .onSubmit {
                    focusState?.toggle()
                }
            }
            
            SecureField("请输入密码", text: $password)
                .textFieldStyle(.roundedBorder)
                .focused($focusState, equals: .password)
                .keyboardType(.numberPad)
                        
            Button("输入姓名") {
                focusState = .username
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("TextField")
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Cancel") {
//                                focusState = nil
                        hideKeyboard()
                    }
                    
                    Button("Next") {
                        focusState?.toggle()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
