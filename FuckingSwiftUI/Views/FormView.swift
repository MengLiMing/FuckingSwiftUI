//
//  FormView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct FormView: View {
    var body: some View {
        Form {
            Section {
                Text("Plain Text")
                Stepper(value: .constant(0), in: 0...10) {
                    Text("Stepper")
                }
                DatePicker("日期", selection: .constant(.now))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Form")
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
