//
//  BlurView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct BlurDemo: View {
    var body: some View {
        ZStack {
            Color.red
            
            BlurView(style: .regular)
                .cornerRadius(10)
                .padding()
        }
        .navigationTitle("UIVisualEffectView")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct BlurDemo_Previews: PreviewProvider {
    static var previews: some View {
        BlurDemo()
    }
}
