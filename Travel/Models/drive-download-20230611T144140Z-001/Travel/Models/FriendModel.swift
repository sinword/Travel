//
//  FriendModel.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseDatabase

class FriendModel: ObservableObject{
    @Published var userList = [UserObject]()
    @Published var invitations = [UserObject]()
    var reference = Database.database().reference()

    func getFriendList(uid: String){
        self.userList = [UserObject]()
        self.invitations = [UserObject]()
        self.reference.child("Friends/\(uid)").observeSingleEvent(of: .value){
            parentSnapshot, error in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else{
                return 
            }
            print(children)
            for snapshot in children{
                let status = snapshot.value as? Bool ?? false
                self.getUserInfo(uid: snapshot.key, status: status)

            }
        }
    }
    
    func getUserInfo(uid: String, status: Bool){
        var user = UserObject()
        self.reference.child("User/\(uid)")
            .observeSingleEvent(of: .value){ snapshot, error in
                let value = snapshot.value as? NSDictionary
                user.email = value?["email"] as? String ?? ""
                user.nickname = value?["displayName"] as? String ?? ""
                let url = value?["photoURL"] as? String ?? ""
                user.profileURL = URL(string: url)!
                user.uid = snapshot.key
                if status{
                    self.userList.append(user)
                }
                else{
                    self.invitations.append(user)
                }
        }
    }
    
    func getUIDFromMail(email: String){
        let ref = Database.database().reference().child("User")
        ref.queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                guard let children = snapshot.children.allObjects as? [DataSnapshot] else{
                    return
                }
                for child in children{
                    print(child.key)
                }
            }
            else {
                print("doesn't exist")
            }
        }
    }
}
