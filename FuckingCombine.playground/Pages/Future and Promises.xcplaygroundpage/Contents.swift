//: [Previous](@previous)

import Foundation
import Combine

struct User {
    let id: Int
    let name: String
}

let users = [User(id: 0, name: "Antoine"), User(id: 1, name: "Henk"), User(id: 2, name: "Bart")]


enum FetchError: Error {
    case userNotFound
}

func fetchUser(for userId: Int, completion: (_ result: Result<User, FetchError>) -> Void) {
    if let user = users.first(where: { $0.id == userId }) {
        completion(.success(user))
    } else {
        completion(.failure(.userNotFound))
    }
}

let fetchUserPublisher = PassthroughSubject<Int, FetchError>()

fetchUserPublisher
    .flatMap { userId -> Future<User, FetchError> in
        Future { promise in
            fetchUser(for: userId) { result in
                switch result {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    .map { user in user.name }
    .replaceError(with: "Not Found")
    .sink { result in
        print("user is \(result)")
    }

fetchUserPublisher.send(0)
fetchUserPublisher.send(5)

//: [Next](@next)
