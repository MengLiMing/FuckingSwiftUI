//: [Previous](@previous)

import Foundation
import Combine

let publisher1 = PassthroughSubject<Int, Never>()

let publisher2 = publisher1.map {
    $0 + 100
}

let subscrption1 = publisher1.sink { value in
    print("Subscription1: \(value)")
}

let subscription2 = publisher2.sink { value in
    print("Subscription2: \(value)")
}

publisher1.send(28)

publisher1.send(50)

subscrption1.cancel()
subscription2.cancel()

let publisher3 = publisher1.filter { $0 % 2 == 0 }

let subscription3 = publisher3.sink { value in
    print("Subscription3: \(value)")
}

publisher1.send(14)
publisher1.send(15)
publisher1.send(16)
//: [Next](@next)
