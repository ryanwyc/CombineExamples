//
//  URLProtocolStub.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-29.
//

import Foundation

class URLProtocolStub: URLProtocol {
    /// url string, json data
    var stubbingData: [String: Data] = [
        UrlString.feedbacks: Data(feedbackJson.utf8),
        UrlString.login: Data(loginJson.utf8)
    ]

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        if let url = request.url, let data = stubbingData[url.absoluteString] {
            //print(url, String(data: data, encoding: .utf8))
            self.client?.urlProtocol(self, didLoad: data)
        }

        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}

extension URLSession {
    class var stubbing: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }
}

fileprivate let feedbackJson: String = """
[
{ "id": "1001", "title": "Cannot login!", "content": "Please fix it.", "reportDate": "2020-10-01 10:10:00"},
{ "id": "1002", "title": "Cannot find my account!", "content": "Please fix it.", "reportDate": "2020-10-02 10:10:00"}
]
"""

fileprivate let loginJson: String = """
{
"id": "1234"
}
"""
