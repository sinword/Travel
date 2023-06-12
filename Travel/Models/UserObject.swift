//
//  UserObject.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/11.
//

import Foundation

struct UserObject: Hashable, Encodable, Decodable{
    var email: String = ""
    var nickname: String = ""
    var profileURL: URL = URL(string: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2Fe6496bba-3356-11ec-91da-063c6e372e74.jpg?crop=2667%2C1500%2C0%2C0")!
    var uid: String = ""
    var status: Bool = false
}

extension Encodable{
    var toDict: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else{
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
