//: [Previous](@previous)

import Foundation
import Combine
import UIKit

final class FormViewModel {
    @Published var isSubmitAllowed: Bool = true
}

final class FormViewController: UIViewController {
    var viewModel = FormViewModel()
    let submitButton = UIButton()
    
    var disposeBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$isSubmitAllowed
            .receive(on: DispatchQueue.main)
            .print()
            .assign(to: \.isEnabled, on: submitButton)
            .store(in: &disposeBag)
    }
}


print("* Demonstrating @Published")

let formViewController = FormViewController(nibName: nil, bundle: nil)
formViewController.viewDidLoad()
print("Button enabled is \(formViewController.submitButton.isEnabled)")

formViewController.viewModel.isSubmitAllowed = false
DispatchQueue.main.async {
    print("Button enabled is \(formViewController.submitButton.isEnabled)")
}

print("\n * Demonstrating ObservableObject")

class ObservableFormViewModel: ObservableObject {
    @Published var isSubmitAllowed: Bool = true
    @Published var username: String = ""
    @Published var password: String = ""
    
    var somethingElse: Int = 10
}

var form = ObservableFormViewModel()

let formSubscription = form.objectWillChange.sink { _ in
    print("Form changed: \(form.isSubmitAllowed) \"\(form.username)\" \"\(form.password)\"")
}

form.isSubmitAllowed = false
form.username = "Florent"
form.password = "12345"
form.somethingElse = 0

//: [Next](@next)
