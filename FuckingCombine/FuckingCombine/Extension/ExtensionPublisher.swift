//
//  ExtensionPublisher.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/20.
//

import Combine

public extension Publisher {
    func flatMapLatest<T>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, T.Failure> where T: Publisher, Self.Failure == Never {
        map { transform($0) }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
