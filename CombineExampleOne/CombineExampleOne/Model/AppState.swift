//
//  UserSetting.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-27.
//

import Combine

final class AppState: ObservableObject {
    @Published var loginedUser: User?
}
