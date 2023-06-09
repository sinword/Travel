//
//  UserSettings.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/9.
//

import Foundation

class UserSettings: ObservableObject{
    var id = UUID()
    var email: String = ""
    var nickName: String = ""
    var passwd: String = ""
    var profileImageUrl: String = ""
    @Published var isLogin: Bool = false
    
}
