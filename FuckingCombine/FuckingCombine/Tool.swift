//
//  Tool.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI
import Combine

func request(failure: Bool, completion: @escaping (Bool) -> Void) {
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .seconds(Int.random(in: 0...1))) {
        if failure {
            completion(false)
        } else {
            completion(true)
        }
    }
}


struct PostmanTimeCheckResponse: Decodable {
    let valid: Bool
}

let jsonDecoder = JSONDecoder()

let dateFormater = { () -> DateFormatter in
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-MM-dd"
    return formater
}()


func postmanTimeCheck(date: Date) -> AnyPublisher<PostmanTimeCheckResponse, Error> {
    let url = URL(string: "https://postman-echo.com/time/valid?timestamp=\(dateFormater.string(from: date))")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: PostmanTimeCheckResponse.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
}

