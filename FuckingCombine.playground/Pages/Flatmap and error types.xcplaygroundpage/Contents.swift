//: [Previous](@previous)

import Foundation
import Combine
import UIKit

enum RequestError: Error {
case sessionError(error: Error)
}

let urlPublisher = PassthroughSubject<URL, RequestError>()

let subscription = urlPublisher.flatMap { url in
    URLSession.shared
        .dataTaskPublisher(for: url)
        .mapError { error in
            RequestError.sessionError(error: error)
        }
}
    .assertNoFailure()
    .sink { result in
        print("Request completed")
        _ = UIImage(data: result.data)
    }

urlPublisher.send(URL(string: "https://httpbin.org/image/jpeg")!)

//: [Next](@next)
