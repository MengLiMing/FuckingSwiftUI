//
//  ExtensionPublisher.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import Foundation
import Combine


//    let ss: AnyPublisher<PostmanTimeCheckResponse, Error> = publisher
//          .map { _ in
//              postmanTimeCheck(date: .now)
//                  .print()
//          }
//          .switchToLatest()
//          .eraseToAnyPublisher()

/// 简单对RxSwift实现的操作符，使用应该按照Combine的风格去封装对应的Publisher
public extension Publisher where Self.Failure == Never {
    func flatMapLatest<T>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, T.Failure> where T: Publisher{
        map { transform($0) }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}

public extension Publisher {
    func flatMapLatest<T>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, Self.Failure> where T: Publisher, Self.Failure == T.Failure {
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


public extension Publisher {
    /// 回顾历史事件 - 可以用来比对两次事件
    /// 用途：UIKit中 用来处理单选可以只刷新 之前选择和当前选择的行
    /// - Returns: 返回 (oldValue?, newValue)
    func review() -> AnyPublisher<(Output?, Output), Failure> {
        review(1)
            .map { ($0.0.first, $0.1) }
            .eraseToAnyPublisher()
    }
    
    
    /// 回顾历史事件
    /// - Parameter count: 回顾之前多少个历史事件
    /// - Returns: 返回 ([oldValue], newValue)
    func review(_ count: Int) -> AnyPublisher<([Self.Output], Self.Output), Self.Failure> {
        if count <= 0 { return map { ([], $0)}.eraseToAnyPublisher() }
        return scan([]) { $0.suffix(count) + [$1] }
            .map { (Array($0[0..<$0.count-1]), $0[$0.count - 1]) }
            .eraseToAnyPublisher()
    }
}


public extension Publisher {
    var resultPublisher: AnyPublisher<Result<Output, Failure>, Never> {
        map { .success($0) }
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
