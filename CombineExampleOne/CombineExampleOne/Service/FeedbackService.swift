//
//  FeedbackService.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-29.
//

import Foundation
import Combine

struct UrlString {
    static let login = "https://test.com/login"
    static let feedbacks = "https://test.com/feedbacks"
}

final class FeedbackService {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func fetchFeedbacksPublisher() -> AnyPublisher<[Feedback], Error> {
        guard let url = URL(string: UrlString.feedbacks) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return urlSession
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Feedback].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

    func loginPublisher(username: String, password: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: UrlString.login) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Bool in
                guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                guard data.count > 0 else {
                    throw URLError(.zeroByteResource)
                }
                return true
            }
            .mapError { $0 as Error}
            .eraseToAnyPublisher()
    }
}

