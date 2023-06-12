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
        @Published var showAlert = false
        @Published var errorMessage = ""
        @Published var showNotify = false
        var reference = Database.database().reference().child("Friends")

        func getFriendList(uid: String){
            print(uid)
            self.userList = [UserObject]()
            self.invitations = [UserObject]()
            self.reference.child("\(uid)").observeSingleEvent(of: .value){
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
        
        func delFriendInvitation(uid: String, targetUid: String){
            self.reference.child("\(uid)/\(targetUid)").removeValue()
            self.getFriendList(uid: uid)
        }
        
        func delFriend(uid: String, targetUid: String){
            self.reference.child("\(uid)/\(targetUid)").removeValue()
            self.reference.child("\(targetUid)/\(uid)").removeValue()
            self.getFriendList(uid: uid)
        }
        
        func addFriend(uid: String, targetUid: String){
            //uid 設為 true
            self.reference.child("\(uid)").updateChildValues(["\(targetUid)": true])
            //targetUid 新增好友
            self.reference.child("\(targetUid)").updateChildValues(["\(uid)": true])
            self.getFriendList(uid: uid)
        }
        
        func getUserInfo(uid: String, status: Bool){
            var user = UserObject()
            let ref = Database.database().reference()
            ref.child("User/\(uid)")
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
        
        func sendInvitation(uid: String, email: String){
            let ref = Database.database().reference().child("User")
            ref.queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.exists() {
                    guard let children = snapshot.children.allObjects as? [DataSnapshot] else{
                        return
                    }
                    var targetUid: String = ""
                    for child in children{
                        targetUid = child.key
                    }
                    if targetUid == uid{
                        self.showAlert = true
                        self.showNotify = false
                        self.errorMessage = "不能添加自己好友！"
                        return
                    }
                    self.reference.child("\(targetUid)/\(uid)")
                        .observeSingleEvent(of: .value){ snapshot, error in
                        let value = snapshot.value as? Bool
                        if value == nil{
                            self.reference.child("\(targetUid)").updateChildValues(["\(uid)": false])
                            self.showNotify = true
                            self.showAlert = false
                            print("加好友")
                        }
                        else if value!{
                            self.showAlert = true
                            self.showNotify = false
                            self.errorMessage = "你們已經是好友了！"
                            print("已經是好友")
                        }
                        else if !(value!) {
                            self.showAlert = true
                            self.showNotify = false
                            self.errorMessage = "請耐心等待對方回覆！"
                            print("等待加好友")
                        }
                    }
                   
                }
                else {
                    self.showAlert = true
                    self.showNotify = false
                    self.errorMessage = "Invalid email"
                }
            }
        }
        
        func getUIDFromMail(email: String){
           
        }
        
        
    }
