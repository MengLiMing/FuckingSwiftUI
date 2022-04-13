//: [Previous](@previous)

import Combine
import Foundation

class MyClass {
    var cancellable: Cancellable? = nil
    
    var variable: Int = 0 {
        didSet {
            print("variable: \(variable)")
        }
    }
    
    init(subject: PassthroughSubject<Int, Never>) {
        cancellable = subject.sink(receiveValue: { value in
            self.variable += value
        })
    }
    
    deinit {
        print("MyClass deinit")
    }
}

let subject = PassthroughSubject<Int, Never>()
var object: MyClass? = MyClass(subject: subject)

func emitNextValue(from values: [Int], after delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        var array = values
        subject.send(array.removeFirst())
        if array.isEmpty == false {
            emitNextValue(from: array, after: delay)
        }
    }
}

emitNextValue(from: [1,2,3,4,5,6,7,8], after: 0.5)

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("Nullify object")
//    object = nil
    
    object?.cancellable?.cancel()
}
//: [Next](@next)
