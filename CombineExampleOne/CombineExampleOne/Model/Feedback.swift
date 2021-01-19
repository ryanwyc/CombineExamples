//
//  Feedback.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-29.
//

import Foundation

struct Feedback: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let reportDate: Date
}
