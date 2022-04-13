//
//  PickerView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct PickerView: View {
    @State private var selectedIndex: Int = 0
    
    private let datas = [
        "Swift", "SwiftUI", "Dart", "Flutter"
    ]
    var body: some View {
        Form {
            picker
            
            picker
                .pickerStyle(.menu)
            
            picker
                .pickerStyle(.inline)
            
            picker
                .pickerStyle(.segmented)
            
            picker
                .pickerStyle(.wheel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Picker")
    }
    
    var picker: some View {
        Picker("选择", selection: $selectedIndex.animation()) {
            ForEach(Array(datas.indices), id: \.self) { index in
                Text(datas[index])
                    .tag(index)
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PickerView()
        }
    }
}
