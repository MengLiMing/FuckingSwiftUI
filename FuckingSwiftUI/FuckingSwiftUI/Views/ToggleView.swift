//
//  ToggleView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct ToggleView: View {
    @State private var flag = false
    var body: some View {
        VStack {
            Toggle("开关", isOn: $flag)
            Toggle("开关", isOn: $flag)
                .labelsHidden()
            
            Toggle("开关", isOn: $flag)
                .toggleStyle(.button)
            
            Toggle("开关", isOn: $flag)
                .toggleStyle(.myCircleStyle())

            Toggle("开关", isOn: $flag)
                .toggleStyle(.myToggleStyle())
                .frame(width: 50, height: 25)
        }
        .animation(.default, value: flag)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Toggle")
    }
}

extension ToggleStyle where Self == MyCircleToggleStyle {
    static func myCircleStyle() -> MyCircleToggleStyle {
        .init()
    }
}

extension ToggleStyle where Self == MyRectangleToggleStyle {
    static func myToggleStyle(_ openColor: Color = .green, _ closeColor: Color = .red, indicatorColor: Color = .white) -> MyRectangleToggleStyle {
        .init(openColor: openColor, closeColor: closeColor, indicatorColor: indicatorColor)
    }
}

struct MyCircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

struct MyRectangleToggleStyle: ToggleStyle {
    let openColor: Color
    let closeColor: Color
    
    let indicatorColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Color.clear
            .overlay(
                GeometryReader { geo in
                    ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(configuration.isOn ? openColor : closeColor)
                            .frame(width: geo.size.width, height: geo.size.height)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: geo.size.width/2 - 4, height: geo.size.height * 0.75)
                            .padding(.horizontal, 4)
                            .foregroundColor(.white)
                            .onTapGesture {
                                withAnimation {
                                    configuration.isOn.toggle()
                                }
                            }
                    }
                }
            )
        
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}


