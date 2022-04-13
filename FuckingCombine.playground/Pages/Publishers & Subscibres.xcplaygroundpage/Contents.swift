import Combine
import SwiftUI

let publisher1 = Just(42)

publisher1.sink { value in
    print("publisher1: \(value)")
}

let publisher2 = [1,2,3,4,5].publisher

publisher2.sink { value in
    print("publisher2: \(value)")
}

let publisher3 = ["a": "A", "b": "B"].publisher

publisher3.sink { value in
    print("publisher3: \(value)")
}

class User {
     var name: String = "" {
        didSet {
            print("设置name: \(name)")
        }
    }
}

var object = User()
Just("Ming").assign(to: \.name, on: object)
    .cancel()
//: [Next](@next)
