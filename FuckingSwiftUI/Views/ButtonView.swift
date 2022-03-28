//
//  ButtonView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct ButtonView: View {
    @State private var isSelcted: Bool = false
    
    var body: some View {
        VStack {
            Button("点击") {
                isSelcted.toggle()
            }
            
            Button {
                isSelcted.toggle()
            } label: {
                Label("分享", systemImage: "square.and.arrow.up.circle.fill")
                    .padding()
            }
            .border(.red, width: 1)
            
            Button(role: .destructive) {
                isSelcted.toggle()
            } label: {
                Label("分享", systemImage: "square.and.arrow.up.circle.fill")
                    .padding()
            }
            
            Group {
                Button("点击") {
                    isSelcted.toggle()
                }
                .buttonStyle(.bordered)
                
                Button("点击") {
                    isSelcted.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("点击") {
                    isSelcted.toggle()
                }
                .buttonStyle(.borderless)
            }
            
            Group {
                Button("自定义") {
                }
                .buttonStyle(.myStyle())
                
                Button {
//                    isSelcted.toggle()
                } label: {
                    Image("icon")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .overlay(Text("自定义：在我身上拖动").foregroundColor(.red))
                }
                .buttonStyle(.myPrimitiveStyle(.black))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Button")
        .popover(isPresented: $isSelcted, content: {
            SencondView()
        })
    }
    
    struct SencondView: View {
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            Button("消失") {
                dismiss()
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}

extension ButtonStyle where Self == MyButtonStyle {
    static func myStyle() -> MyButtonStyle {
        .init()
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
            .shadow(radius: configuration.isPressed ? 10 : 4)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}

extension PrimitiveButtonStyle where Self == MyPrimitiveButtonStyle {
    static func myPrimitiveStyle(_ shadowColor: Color) -> MyPrimitiveButtonStyle {
        .init(shadowColor: shadowColor)
    }
}

struct MyPrimitiveButtonStyle: PrimitiveButtonStyle {
    enum TapLocation {
        case left
        case right
    }
    
    var shadowColor: Color
    
    @State private var size: CGSize?
    @State private var location: TapLocation?
    
    @State private var dragPoint: UnitPoint = .center
    
    func makeBody(configuration: Configuration) -> some View {
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged({ value in
                if let size = self.size,
                    size.width > 0,
                    size.height > 0 {
                    DispatchQueue.main.async {
                        dragPoint = .init(
                            x: max(0, min(1, value.location.x/size.width)),
                            y: max(0, min(1, value.location.y/size.height)))
                    }
                }
            })
            .onEnded { _ in
                DispatchQueue.main.async {
                    dragPoint = .center
                }
            }

        let tapGesture = TapGesture()
            .onEnded {
                configuration.trigger()
            }
        
        configuration.label
            .padding(15)
            .shadow(radius: 10)
            .shadow(color: shadowColor.opacity(0.8), radius: 3, x: (dragPoint.x - 0.5) * -10, y: (dragPoint.y - 0.5) * -10)
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: MyPrimitiveKey.self, value: [geo.size])
                }
            )
            .onPreferenceChange(MyPrimitiveKey.self, perform: { preference in
                size = preference.first
            })
            .gesture(
                SimultaneousGesture(tapGesture, dragGesture)
            )
            .modifier(MyRotation(point: dragPoint))
    }
    
    var rotationAngle: Angle {
        guard let location = location else {
            return .zero
        }
        switch location {
        case .left:
            return .degrees(-30)
        case .right:
            return .degrees(30)
        }
    }
    
    struct MyRotation: GeometryEffect {
        var point: UnitPoint
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            print(point)
            var transform3D = CATransform3DIdentity
            transform3D.m34 = -1/1000

            transform3D = CATransform3DRotate(transform3D, Angle.degrees(10 * (point.x - 0.5)).radians, 0, 1, 0)
            transform3D = CATransform3DRotate(transform3D, Angle.degrees(-10 * (point.y - 0.5)).radians, 1, 0, 0)
            
            return ProjectionTransform()
                .concatenating(CGAffineTransform.init(translationX: -size.width/2, y: -size.height/2))
                .concatenating(transform3D)
                .concatenating(CGAffineTransform.init(translationX: size.width/2, y: size.height/2))
        }
    }
    
    struct MyPrimitiveKey: PreferenceKey {
        static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
            value.append(contentsOf: nextValue())
        }
        
        static var defaultValue: [CGSize] = []
    }
}

