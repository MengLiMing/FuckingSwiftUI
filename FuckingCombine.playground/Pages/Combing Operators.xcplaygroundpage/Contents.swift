//: [Previous](@previous)

import Foundation
import Combine

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCredentialsSubscritpion = usernamePublisher.combineLatest(passwordPublisher)
    .map { (username, password) in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

usernamePublisher.send("avanderlee")
passwordPublisher.send("weakpass")
passwordPublisher.send("verystorngpassword")

let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<Int, Never>()

let mergedPublishersSubscription = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merger: subscription received value \(value)")
    }

publisher1.send(1)
publisher1.send(2)
publisher2.send(300)
publisher2.send(400)
publisher1.send(3)
publisher1.send(4)
publisher2.send(500)
publisher1.send(5)
//: [Next](@next)
