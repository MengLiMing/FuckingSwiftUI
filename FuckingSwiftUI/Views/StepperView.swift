//
//  StepperView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct StepperView: View {
    @State var number: Int = 0
    
    var body: some View {
        VStack {
            Stepper {
                Text("数量")
            } onIncrement: {
                number += 1
            } onDecrement: {
                number -= 1
            } onEditingChanged: { _ in
                
            }
            
            Stepper("数量", value: $number, in: 0...100, step: 1)
            
            Stepper(value: $number, in: 0...100, label: {
                Text("数量")
            })
            .labelsHidden()

            Text("\(number)")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Stepper")
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
