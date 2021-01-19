//
//  SubjectBinding.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2021-01-04.
//

import Combine
import SwiftUI

/// https://github.com/serbats/Reactive-Combine-MVVM-Templates/blob/main/SwiftUITestProj/PropertyWrappers/SubjectBinding.swift
@propertyWrapper
struct SubjectBinding<Value> {
    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue: Value) {
        subject = CurrentValueSubject<Value, Never>(wrappedValue)
    }

    func anyPublisher() -> AnyPublisher<Value, Never> {
        return subject.eraseToAnyPublisher()
    }

    var wrappedValue: Value {
        get {
            return subject.value
        }
        set {
            subject.value = newValue
        }
    }

    var projectedValue: Binding<Value> {
        return Binding<Value>(get: { () -> Value in
            return self.subject.value
        }) { (value) in
            self.subject.value = value
        }
    }
}
