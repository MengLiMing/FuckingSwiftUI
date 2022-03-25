//
//  ConfirmationDialogView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @State private var flag = false
    var body: some View {
        Button("Show") {
            flag.toggle()
        }
        .confirmationDialog(
            "Title",
            isPresented: $flag
        ) {
            Button("Swift") {

            }
            Button("SwiftUI", role: .destructive) {

            }

            Button("取消", role: .cancel) {

            }
        } message: {
            Text("Message")
        }
        .navigationTitle("ActionSheet")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfirmationDialogView()
        }
    }
}
