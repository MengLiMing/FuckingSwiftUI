//: [Previous](@previous)

import Combine

/*:
 ## Example 1
 */

let subject = PassthroughSubject<String, Never>()

subject.send("Hi")
let subscription1 = subject.sink { value in
    print("subscription1: \(value)")
}

subject.send("Hello")
subject.send("World!")


/*:
 ## Example2
 */

let publisher = ["A", "B", "C"].publisher

publisher
    .subscribe(subject)


/*:
 ## Example3
 */
let subject2 = CurrentValueSubject<String, Never>("a")

let subscription2 = subject2.sink { value in
    print("subscription2: \(value)")
}

subject2.send("b")
subject2.send("c")
subject2.send(completion: .finished)
subject2.send("d")

//: [Next](@next)
