//: [Previous](@previous)

import Foundation
import Combine
import UIKit

struct DecodableExample: Decodable { }


URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.avanderlee.com/feed/")!)
    .map { $0.data }
    .decode(type: DecodableExample.self, decoder: JSONDecoder())

NotificationCenter.default.publisher(for: .NSSystemClockDidChange)

let ageLabel = UILabel()
Just(28)
    .map { "Age is \($0)" }
    .assign(to: \.text, on: ageLabel)

let pubslisher = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

//: [Next](@next)
