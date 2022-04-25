//
//  OnReceiveView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/21.
//

import SwiftUI
import Combine

struct OnReceiveView: View {
    
    @State private var date: Date = .now
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formater.locale = Locale(identifier: "zh_cn")
        return formater
    }()
    
    var body: some View {
        Text(dateFormater.string(from: date))
            .onReceive(timer) { _ in
                date = .now
            }
    }
}

struct OnReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        OnReceiveView()
    }
}
