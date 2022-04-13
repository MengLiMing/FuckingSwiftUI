//: [Previous](@previous)

import Combine

enum ExampleError: Error {
    case error
}

let subject = PassthroughSubject<String, ExampleError>()

let subscription = subject.handleEvents { subscription in
    print("New subscription")
} receiveOutput: { value in
    print("收到新元素")
} receiveCompletion: { _ in
    print("订阅完成")
} receiveCancel: {
    print("订阅取消")
} receiveRequest: { value in
    print("收到请求：\(value)")
}
.replaceError(with: "发生错误")
.sink { value in
    print("收到: \(value)")
}

subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: .failure(.error))
subject.send("Hello?? :(")

//: [Next](@next)
