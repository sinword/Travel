//
//  UserModel.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import UIKit

class UserModel: ObservableObject{
    @Published var user: UserObject? = nil
    @Published var selectedPhotoData: Data? = UIImage(systemName: "person.circle.fill")?.pngData() //Default
    
    
    @Published var isValid = true
    @Published var sumbitDone = false
    @Published var errorMessage = ""
    
    var uid: String
    var reference = Database.database().reference()
    var nicknameTmp = ""
    var noteTmp = ""
    
    
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
                self.user?.note = value?["note"] as? String ?? ""
                self.nicknameTmp = self.user!.nickname
                self.noteTmp = self.user!.note
                print(self.user!.profileURL)
        }
    }
    
    func updateProfile(user: User){
        guard let data = self.selectedPhotoData else {
            self.errorMessage = "請上傳有效圖片"
            self.isValid = false
            return
        } // Checks whether there is actual data to upload.
        
        let storageRef = Storage.storage().reference()
        //TODO: Replace it with ID
        let fileRef = storageRef.child("\(user.uid)/Profile.png")
        
        if data == UIImage(systemName: "person.circle.fill")?.pngData(){
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = self.nicknameTmp
            changeRequest.commitChanges{ error in
                if error != nil{
                    self.errorMessage = error!.localizedDescription
                    self.isValid = false
                }
                else{
                    let ref = Database.database().reference()
                    ref.child("User/\(user.uid)/displayName").setValue(self.nicknameTmp)
                    ref.child("User/\(user.uid)/note").setValue(self.noteTmp)
                    self.isValid = true
                    self.sumbitDone = true
                }
            }
        }
        else{
            let uploadTask = fileRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                let changeRequest = user.createProfileChangeRequest()
                
                let profileRef = storageRef.child("\(user.uid)/Profile.png")
                profileRef.downloadURL { url, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.isValid = false
                    } else {
                        changeRequest.photoURL =  url
                        changeRequest.displayName = self.nicknameTmp
                        changeRequest.commitChanges{ error in
                            if error != nil{
                                self.errorMessage = error!.localizedDescription
                                self.isValid = false
                            }
                            else{
                                let ref = Database.database().reference()
                                ref.child("User/\(user.uid)/displayName").setValue(self.nicknameTmp)
                                ref.child("User/\(user.uid)/note").setValue(self.noteTmp)
                                ref.child("User/\(user.uid)/photoURL").setValue(url?.absoluteString)
                                self.isValid = true
                                self.sumbitDone = true
                            }
                        }
                    }
                }
            }
        }
       
    }
    
}
