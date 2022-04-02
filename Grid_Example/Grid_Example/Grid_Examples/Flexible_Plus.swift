//
//  Flexible_Plus.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/2.
//

import SwiftUI

struct Flexible_Plus: View {
    let gridItems = [
        GridItem(.flexible(minimum: 40), spacing: 10),
        GridItem(.fixed(40), spacing: 2),
        GridItem(.flexible(minimum: 30), spacing: 20),
        GridItem(.flexible(minimum: 100), spacing: 100)
    ]

    @State private var width: CGFloat = 0
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems) {
                items(10)
            }
            .widthChangeable($width)
            
            drawResult(gridItems, contentWidth: width)
        }
    }
    
    func drawResult(_ items: [GridItem], contentWidth: CGFloat) -> some View {
        let result = draw(items, contentWidth: contentWidth)
        return HStack {
            ForEach(result, id: \.self) { value in
                Text("\(value, specifier: "%.2f")")
            }
        }
    }
}

struct Flexible_Plus_Previews: PreviewProvider {
    static var previews: some View {
        Flexible_Plus()
    }
}

extension View {
    func draw(_ items: [GridItem], contentWidth: CGFloat) -> [CGFloat] {
        let result1 = calculate(items, contentWidth: contentWidth).reduce(into: 0) { $0 += $1 }
        let spacings = items.dropLast().reduce(into: 0) { $0 += ($1.spacing ?? 8) }

        return calculate(items, contentWidth: result1 + spacings)
    }

    func calculate(_ items: [GridItem], contentWidth: CGFloat) -> [CGFloat] {
        var result = Array<CGFloat>(repeating: 0, count: items.count)

        var dynamicWidth = contentWidth
        
        var dynamicCount = items.count

        /// 减去固定宽度列的宽度，以及列之间的间距
        for (index, item) in items.enumerated() {
            if index != items.count - 1 {
                dynamicWidth -= (item.spacing ?? 8)
            }

            if case .fixed(let width) = item.size {
                dynamicCount -= 1
                dynamicWidth -= width
            }

        }

        if dynamicCount > 0 {
            /// 遍历所有列
            for (index, item) in items.enumerated() {
                switch item.size {
                case let .flexible(minimum, maximum):
                    let singleWidth = dynamicWidth / CGFloat(dynamicCount)
                    let width = min(maximum, max(minimum, singleWidth))
                    result[index] = width

                    dynamicCount -= 1
                    dynamicWidth -= width
                case .fixed(let width):
                    result[index] = width
                case .adaptive:
                    /// 此处下一章补全
                    continue

                @unknown default:
                    continue

                }
            }
        }
        return result
    }
}

