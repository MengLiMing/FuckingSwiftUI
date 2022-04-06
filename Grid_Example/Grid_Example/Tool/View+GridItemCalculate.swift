//
//  View+GridItemCalculate.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/6.
//

import SwiftUI

extension View {

    func draw(_ items: [GridItem], contentWidth: CGFloat) -> [[CGFloat]] {
        let calculateResult = calculate(items, contentWidth: contentWidth)
        var result: CGFloat = 0
        for index in 0..<items.count {
            let item = items[index]
            let itemWidths = calculateResult[index]
            let space = (item.spacing ?? 8)
            
            if itemWidths.count > 1 {
                result += (itemWidths.reduce(0) { $0 + $1 } + CGFloat(itemWidths.count - 1) * space)
            } else {
                result += itemWidths.first!
            }
            if index != items.count - 1 {
                result += space
            }
        }
        return calculate(items, contentWidth: result)
    }

    

    func calculate(_ items: [GridItem], contentWidth: CGFloat) -> [[CGFloat]] {
        print(contentWidth)
        var result = Array<[CGFloat]>(repeating: [0], count: items.count)

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
                    result[index] = [width]

                    dynamicCount -= 1
                    dynamicWidth -= width
                case .fixed(let width):
                    result[index] = [width]
                case let .adaptive(minimum, maximum):
                    let singleWidth = dynamicWidth / CGFloat(dynamicCount)
                    /// 计算最多显示多少列
                    let space = item.spacing ?? 8
                    /// space + minimum 这里我就不判断是否为0了，代码中设置.adaptive(minimum: 0), spacing: 0)会崩溃, 所以我猜内部也是这样计算的吧。。。
                    let maxColumn = max(1, Int((singleWidth + space) / (space + minimum)))
                    /// 每一行的宽度为
                    let singleColumnWidth = (singleWidth - CGFloat(maxColumn - 1) * space) / CGFloat(maxColumn)
                    let adaptiveResult = Array<CGFloat>(repeating: min(maximum, max(0, singleColumnWidth)), count: maxColumn)
                    
                    result[index] = adaptiveResult
                    
                    let width = adaptiveResult.reduce(into: 0) { $0 += $1 } + CGFloat(maxColumn - 1) * space
                    
                    dynamicCount -= 1
                    dynamicWidth -= width
                @unknown default:
                    continue

                }
            }
        }
        return result
    }
}
