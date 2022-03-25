//
//  AlertView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct AlertView: View {
    @State var isShowMessage: Bool = false
    
    private let message: String = "我是消息"
    
    var body: some View {
        VStack {
            Button("Message") {
                isShowMessage.toggle()
            }
        }
        .alert("我是标题", isPresented: $isShowMessage, presenting: message, actions: { item in
            Button("OK") {
                
            }
        }) { item in
            Text(item)
        }
        .navigationTitle("Alert")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
