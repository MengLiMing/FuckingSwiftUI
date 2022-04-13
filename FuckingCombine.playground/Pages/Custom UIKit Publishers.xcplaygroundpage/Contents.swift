//: [Previous](@previous)

import Foundation
import Combine
import UIKit

final class UIControllerSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    
    private var subscriber: SubscriberType?
    private let control: Control
    
    init(subscriber: SubscriberType, control: Control, event: Control.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
    
    deinit {
        print("UIControllerTarget deinit")
    }
}

struct UIControlPublisher<Control: UIControl>: Publisher {
    typealias Output = Control
    
    typealias Failure = Never
    
    let control: Control
    let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Control == S.Input {
        subscriber.receive(subscription: UIControllerSubscription(subscriber: subscriber, control: control, event: controlEvents))
    }
    
}


protocol CombineCompatible { }
extension UIControl: CombineCompatible { }

extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}

let button = UIButton()
let subscription = button.publisher(for: .touchUpInside).sink { button in
    print("Button is pressed!")
}

button.sendActions(for: .touchUpInside)
subscription.cancel()

extension CombineCompatible where Self: UISwitch {
    var isOnPublisher: AnyPublisher<Bool, Never> {
        publisher(for: [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}

let switcher = UISwitch()
switcher.isOn = false
let submitButton = UIButton()
submitButton.isEnabled = false

//switcher.publisher(for: \.isOn).assign(to: \.isEnabled, on: submitButton)
switcher.isOnPublisher.assign(to: \.isEnabled, on: submitButton)

switcher.isOn = true
switcher.sendActions(for: [.valueChanged])
print(submitButton.isEnabled)

//: [Next](@next)
