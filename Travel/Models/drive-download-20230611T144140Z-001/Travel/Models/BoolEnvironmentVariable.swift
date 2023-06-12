//
//  BoolEnvironmentVariable.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/9.
//

import Foundation

class BoolEnvironmentVariable: ObservableObject {
    @Published var isEnable: Bool
    init() {
        isEnable = false
    }
}
