//: [Previous](@previous)

import Foundation
import Combine

let firstStepDone = DispatchSemaphore(value: 0)

print("* Demonstrating receive(on:)")

let publisher = PassthroughSubject<String, Never>()
let receivingQueue = DispatchQueue(label: "receiving-queue")
let subscription = publisher
    .receive(on: receivingQueue)
    .sink { value in
        print("Received value: \(value) on thread \(Thread.current)")
        if value == "Four" {
            firstStepDone.signal()
        }
}

for string in ["One","Two","Three","Four"] {
    DispatchQueue.global().async {
        publisher.send(string)
    }
}

firstStepDone.wait()

let subscription2 = [1,2,3,4,5].publisher
    .subscribe(on: DispatchQueue.global())
    .handleEvents(receiveOutput: { value in
        print("Value \(value) emitted on thread \(Thread.current)")
    })
    .receive(on: receivingQueue)
    .sink { value in
        print("Received value: \(value) on thread \(Thread.current)")
    }

//: [Next](@next)
