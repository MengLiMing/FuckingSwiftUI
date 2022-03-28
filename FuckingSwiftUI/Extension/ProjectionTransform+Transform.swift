//
//  ProjectionTransform+Transform.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

public extension ProjectionTransform {
    func concatenating(_ m: CATransform3D) -> ProjectionTransform {
        concatenating(ProjectionTransform(m))
    }
    
    func concatenating(_ m: CGAffineTransform) -> ProjectionTransform {
        concatenating(ProjectionTransform(m))
    }
}
