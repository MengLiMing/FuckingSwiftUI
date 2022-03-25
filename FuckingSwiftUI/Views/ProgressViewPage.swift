//
//  ProgressViewPage.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct ProgressViewPage: View {
    @State private var progress = 0.0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
    @State private var waveProgress = 0.0
    
    var body: some View {
        VStack {
            ProgressView("进度", value: progress, total: 100)
                .progressViewStyle(.linear)
            
            ProgressView("进度", value: progress, total: 100)
                .progressViewStyle(.circular)
            
            ProgressView("进度", value: progress, total: 100)
                .progressViewStyle(.myProgressStyle())
                .frame(width: 200, height: 200)
            
            ProgressView("", value: progress, total: 100)
                .progressViewStyle(.myWaveStyle())
                .frame(width: 200, height: 200)
            
            ProgressView("", value: waveProgress, total: 100)
                .progressViewStyle(.myWaveStyle())
                .frame(width: 200, height: 200)
    
            HStack {
                Button("0%") {
                    withAnimation(.easeInOut(duration: 2)) {
                        waveProgress = 0
                    }
                }
                .buttonStyle(.bordered)
                .padding()
                
                Button("40%") {
                    withAnimation(.easeInOut(duration: 2)) {
                        waveProgress = 40
                    }
                }
                .buttonStyle(.bordered)
                .padding()
                
                Button("90%") {
                    withAnimation(.easeInOut(duration: 2)) {
                        waveProgress = 90
                    }
                }
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("ProgressView")
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 3)) {
                if progress < 100 {
                    progress = min(100, progress + 2)
                }
            }

        }
    }
}

extension ProgressViewStyle where Self == MyProgressViewStyle {
    static func myProgressStyle(strokeColor: Color = .blue, strokeWidth: Double = 20) -> MyProgressViewStyle {
        MyProgressViewStyle(strokeColor: strokeColor, strokeWidth: strokeWidth)
    }
}

struct MyProgressViewStyle: ProgressViewStyle {
    var strokeColor: Color = .blue
    var strokeWidth: Double
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0
        
        return Circle()
            .trim(from: 0, to: progress)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth))
            .padding(strokeWidth/2)
            .overlay(
                Text("\(Int(progress * 100))%")
                    .font(.largeTitle)
            )
    }
}

extension ProgressViewStyle where Self == MyWaveProgressStyle {
    static func myWaveStyle() -> MyWaveProgressStyle {
        .init()
    }
}

struct MyWaveProgressStyle: ProgressViewStyle {
    @State private var waveAnimation = false
    
    func makeBody(configuration: Configuration) -> some View {
         let progress = configuration.fractionCompleted ?? 0
        return ZStack {
            /// 可以对比两种效果
            ZStack {
                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 10, startOffsetDegress: 0)
                    .fill(.blue)
                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 8, startOffsetDegress: 90)
                    .fill(.green)
                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 7, startOffsetDegress: 180)
                    .fill(.red)
            }
            .modifier(OffsetAnimation(pct: progress))
            
//            ZStack {
//                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 10, startOffsetDegress: 0, vPct: progress)
//                    .fill(.blue)
//                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 8, startOffsetDegress: 90, vPct: progress)
//                    .fill(.green)
//                WaveShape(pct:waveAnimation ? 1 : 0, waveHeight: 7, startOffsetDegress: 180, vPct: progress)
//                    .fill(.red)
//            }
        }
        .clipShape(Circle())
        .drawingGroup()
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                waveAnimation = true
            }
        }
    }
    
    struct ClipShape: Shape {
        var pct: Double

        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.width, y: rect.height * (1 - pct)))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height * (1 - pct)))

            path.closeSubpath()
            
            return path
        }
    }
}

/// 竖直方向进度动画 想到的骚操作。。。有其他想法可以联系我
struct OffsetAnimation: Animatable, ViewModifier {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    @State private var size: CGSize?
    
    func body(content: Content) -> some View {
        content
            .currentSize($size)
            .offset(x: 0, y: size == nil ? 0 : size!.height * (1 - pct))
    }
}

/// 水平波纹动画
struct WaveShape: Shape {
    var pct: Double
    
    let waveHeight: CGFloat
    
    let startOffsetDegress: Double
    
    let vPct: Double
        
    init(pct: Double, waveHeight: CGFloat = 10, startOffsetDegress: Double = 0, vPct: Double = 1) {
        self.pct = pct
        self.waveHeight = waveHeight
        self.startOffsetDegress = startOffsetDegress
        self.vPct = vPct
    }
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var x: CGFloat = 0
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        /// 波浪宽度
        let waveWidth = rect.width/4
        
        while x <= rect.width {
            let low = rect.width * (0 + pct)
            
            let degrees = (x - low)/waveWidth * 180 - startOffsetDegress
            let y = sin(Angle(degrees: degrees).radians) * waveHeight - waveHeight
            
            path.addLine(to: CGPoint(x: x, y: y))
            
            x += 1
        }
        
        path.closeSubpath()
        
        /// 在这里直接进行偏移也可以，也更加方便 但是会比较僵硬
        path = path.offsetBy(dx: 0, dy: rect.height * (1 - vPct))
        
        return path
    }
}

struct ProgressViewPage_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewPage()
    }
}

