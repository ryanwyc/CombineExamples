//
//  RootViewModel.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-27.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    //MARK: Output - with default values
    @Published var authStatusText: String = "Has not logged in yet."
    @Published var authStatusButtonText: String = "Login"
    @Published var shouldOpenFeedbackFormView: Bool = false
    @Published var shouldOpenFeedbackListView: Bool = false
    @Published var shouldOpenLoginView: Bool = false

    //var valudatedLogin: AnyPublisher<Published<String>,

    //MARK: Input - PassthroughSubject or func
    let input: PassthroughSubject<RootViewInput, Never> = PassthroughSubject()

    let didTapAuthButton: PassthroughSubject<Void, Never> = PassthroughSubject()
    let didTapOpenFeedbackListButton: PassthroughSubject<Void, Never> = PassthroughSubject()
    let didTapEnterFeedbackFormButton: PassthroughSubject<Void, Never> = PassthroughSubject()

    @SubjectBinding var authButtonBinding: Void = ()

    //MARK: Private Properties
    private var disposables = Set<AnyCancellable>()
    private let appState: AppState

    //MARK: Constructor
    init(appState: AppState) {
        self.appState = appState

        didTapAuthButton.sink { [weak self] in
            if appState.loginedUser == nil {
                /// Login
                let user = User(firstName: "John", lastName: "Bob", lastLogin: Date())
                appState.loginedUser = user
                self?.authStatusText = "Welcome back, \(user.firstName)"
                self?.authStatusButtonText = "Logout"
            } else {
                /// Logout
                appState.loginedUser = nil
                self?.authStatusText = "Has not logged in yet."
                self?.authStatusButtonText = "Login"
            }
        }.store(in: &disposables)

        didTapOpenFeedbackListButton.sink { [weak self] in
            if appState.loginedUser != nil {
                self?.shouldOpenFeedbackListView = true
            } else {
                self?.shouldOpenLoginView = true
            }
        }.store(in: &disposables)

        didTapEnterFeedbackFormButton.sink { [weak self] in
            self?.shouldOpenFeedbackFormView = true
        }.store(in: &disposables)

        let service = FeedbackService(urlSession: .stubbing)
        service.fetchFeedbacksPublisher().sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("finished")
            }
        } receiveValue: { feedbacks in
            print(feedbacks)
        }.store(in: &disposables)

        let task = URLSession.stubbing
            .dataTask(with: URL(string: UrlString.feedbacks)!) { (data, urlResponse, error) in
                print(String(data: data!, encoding: .utf8) ?? "nil")
            }
        task.resume()
    }
}


@available(iOS 13.0, *)
struct Relay<Element> {
    var call: (Element) -> Void { didCall.send }
    var publisher: AnyPublisher<Element, Never> {
        didCall.eraseToAnyPublisher()
    }

    // MARK: Private
    private let didCall = PassthroughSubject<Element, Never>()
}

