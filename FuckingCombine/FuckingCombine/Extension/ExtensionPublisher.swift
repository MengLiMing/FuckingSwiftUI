//
//  ExtensionPublisher.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import Foundation
import Combine

/// 简单对标RxSwift实现的操作符，使用应该按照Combine的风格去封装对应的Publisher
public extension Publisher {
    func flatMapLatest<T>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, T.Failure> where T: Publisher, Self.Failure == Never {
        map { transform($0) }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    func withLatestFrom<O, R>(_ other: O, _ transform: @escaping (Self.Output, O.Output) -> R) -> AnyPublisher<R, Self.Failure> where O: Publisher, Self.Failure == O.Failure {
        
        map { (UUID(), $0) }
            .combineLatest(other) { ($0.0, $0.1, $1) }
            .removeDuplicates(by: { $0.0 == $1.0 })
            .map { transform($0.1, $0.2) }
            .eraseToAnyPublisher()
    }
}
