//
//  DatePickerView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct DatePickerView: View {
    @State private var date = Date.now
    
    var dateCloseRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        
        return min...max
    }
    
    var body: some View {
        Form {
            DatePicker("选择时间",
                       selection: $date,
                       in: dateCloseRange,
                       displayedComponents: .date)
            .datePickerStyle(.compact)
            
            DatePicker("选择时间",
                       selection: $date,
                       in: ...(.now),
                       displayedComponents: [.hourAndMinute, .date])
            .datePickerStyle(.automatic)
            
            DatePicker("选择时间",
                       selection: $date,
                       in: .now...,
                       displayedComponents: [.hourAndMinute, .date])
            .datePickerStyle(.graphical)
            
            DatePicker("选择时间",
                       selection: $date,
                       in: .now...,
                       displayedComponents: [.hourAndMinute, .date])
            .datePickerStyle(.wheel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("DatePicker")
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
