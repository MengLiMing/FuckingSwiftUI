//
//  SliderView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct SliderView: View {
    @State private var progress = 0.0
    
    var body: some View {
        VStack {
            Slider(value: $progress, in: 0...1)
            
            Slider(value: $progress, in: 0...1, step: 0.1) {
                Text("亮度")
            } minimumValueLabel: {
                Image(systemName: "sun.min")
            } maximumValueLabel: {
                Image(systemName: "sun.max.fill")
            } onEditingChanged: { _ in
                
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Slider")
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
