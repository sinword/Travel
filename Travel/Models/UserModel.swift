//
//  UserModel.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseDatabase

class UserModel: ObservableObject{
    @Published var user: UserObject? = nil
    var uid: String
    var reference = Database.database().reference()
    
    init(uid: String){
        self.uid = uid
        self.getUserInfo()
    }
    
    
    func getUserInfo(){
        print(self.uid)
        self.reference.child("User/\(self.uid)")
            .observeSingleEvent(of: .value){ snapshot in
                let value = snapshot.value as? NSDictionary
                self.user = UserObject()
                self.user?.email = value?["email"] as? String ?? ""
                self.user?.nickname = value?["displayName"] as? String ?? ""
                let url = value?["photoURL"] as? String ?? ""
                self.user?.profileURL = URL(string: url)!
                print(self.user!.profileURL)
        }
    }
}
