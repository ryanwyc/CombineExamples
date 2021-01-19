//
//  LoginViewModel.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2021-01-05.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    // MARK: - Input
    @Published var usernameEntered: String = ""
    @Published var passwordEntered: String = ""
    @Published var loginButtonTapped: Bool = false

    // MARK: - Output
    @Published var loginButtonEnabled: Bool = false
    @Published var validationMessage: String = ""

    // MARK: -
    private var disposables = Set<AnyCancellable>()

    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $usernameEntered
            //.debounce(for: 0.8, scheduler: RunLoop.main) // To avoid user type too fast
            .removeDuplicates() // To avoid duplicated input
            .map { !$0.isEmpty } // To check if input is not empty
            .eraseToAnyPublisher() // To expose an instance of ``AnyPublisher`` to the downstream subscriber
    }

    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $passwordEntered
            //.debounce(for: 0.8, scheduler: RunLoop.main) // To avoid user type too fast
            .removeDuplicates() // To avoid duplicated input
            .map { !$0.isEmpty } // To check if input is not empty
            .eraseToAnyPublisher() // To expose an instance of ``AnyPublisher`` to the downstream subscriber
    }

    private var areAllInputsValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher) // to compare the latest value for each of those fields.
            .map { isUsernameValid, isPasswordVaild in // Transform & validation
                return isUsernameValid && isPasswordVaild
            }
            .eraseToAnyPublisher()
    }

    private let service: FeedbackService

    init(service: FeedbackService = FeedbackService()) {
        self.service = service

        $loginButtonTapped
            .debounce(for: 0.8, scheduler: RunLoop.main) // To avoid user type too fast
            .flatMap {
                return Future()
            }
            .store(in: &disposables)

        areAllInputsValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.loginButtonEnabled, on: self) // To update loginButton publisher
            .store(in: &disposables)
    }
}
