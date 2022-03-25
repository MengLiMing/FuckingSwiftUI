//
//  TextEditorView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct TextEditorView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $text)
                    .placeHolder(textChange: $text, placeHolder: .constant("我是占位符"))
                    .padding(.bottom, 30)
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                
                Text("\(text.count) 字数")
                    .padding(.trailing, 10)
                    .padding(.bottom, 5)
            }
            .frame(width: 300, height: 300)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.red, lineWidth: 1))
            
            Text("想实现高度变化的文本编辑框，建议还是使用UITextView代替，当然你也可以使用.background(GeometryReader { geo in Color.clear.onChange {} })计算高度 然后改变高度})，或者使用PreferenceKey获取Label的高度，然后在onPreferenceChange中改变")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("TextEditor")
    }
}

extension View {
    func placeHolder(textChange: Binding<String>, placeHolder: Binding<String>) -> some View {
        modifier(TextEditorPlaceHolder(placeHolder: placeHolder, text: textChange))
    }
}

struct TextEditorPlaceHolder: ViewModifier {
    @Binding var placeHolder: String
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        UITextView.appearance().backgroundColor = .clear
        
        return content
            .background(
                TextEditor(text: $placeHolder)
                    .opacity(text.isEmpty ? 1 : 0)
                    .disabled(true)
                    .foregroundColor(Color(uiColor: .placeholderText))
            )
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
