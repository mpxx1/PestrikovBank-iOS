//
//  UIControl+Extension.swift
//  PestrikovBank
//
//  Created by m on 17.04.2025.
//

import Combine
import UIKit

extension UIControl {
    func publisher(for events: UIControl.Event) -> AnyPublisher<UIControl, Never> {
        UIControlPublisher(control: self, events: events)
            .eraseToAnyPublisher()
    }
}

private struct UIControlPublisher<Control: UIControl>: Publisher {
    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let events: UIControl.Event

    func receive<S>(subscriber: S) where S: Subscriber, S.Input == Control, S.Failure == Never {
        let subscription = Subscription(subscriber: subscriber, control: control, event: events)
        subscriber.receive(subscription: subscription)
    }

    private final class Subscription<S: Subscriber, Control: UIControl>: Combine.Subscription
    where S.Input == Control, S.Failure == Never {
        private var subscriber: S?
        weak private var control: Control?
        let event: UIControl.Event

        init(subscriber: S, control: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event
            control.addTarget(self, action: #selector(eventHandler), for: event)
        }

        func request(_ demand: Subscribers.Demand) { }
        func cancel() {
            subscriber = nil
            control?.removeTarget(self, action: #selector(eventHandler), for: event)
        }

        @objc private func eventHandler() {
            guard let control = control else { return }
            _ = subscriber?.receive(control)
        }
    }
}
