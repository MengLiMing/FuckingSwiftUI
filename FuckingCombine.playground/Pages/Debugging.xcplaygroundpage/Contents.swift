//: [Previous](@previous)

import Foundation
import Combine
import UIKit


enum ExampleError: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<String, ExampleError>()
let subscription = subject.handleEvents { subscription in
    print("Receive subscription")
} receiveOutput: { output in
    print("Receive output: \(output)")
} receiveCompletion: { _ in
    print("Receive completion")
} receiveCancel: {
    print("Receive cancel")
} receiveRequest: { demand in
    print("Receive request: \(demand)")
}
    .replaceError(with: "Error occurred")
    .sink { _ in }

subject.send("Hello!")
subscription.cancel()

let printSubscription = subject.print("Print Exmaple")
    .replaceError(with: "Error occurred")
    .sink { _ in }

subject.send("Hello!")
printSubscription.cancel()

let breakSubscription = subject
    .breakpoint(receiveOutput: { value in
        value == "Hello!"
    })

//: [Next](@next)
