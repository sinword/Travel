//
//  AuthModel.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/10.
//

import Foundation
import Firebase
import FirebaseStorage

class AuthModel: ObservableObject{
    var email = ""
    var password = ""
    var confirmPassword = ""
    var nickname = ""
    var uid = ""
    var profileURL = URL(string: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2Fe6496bba-3356-11ec-91da-063c6e372e74.jpg?crop=2667%2C1500%2C0%2C0")
    
    var selectedPhotoData: Data?
    
    var isValid = true
    var errorMessage = ""
    
    @Published var isLogin = false
    @Published var user: User?

    
    init(){
        registerAuthStateHandler()
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?

      func registerAuthStateHandler() {
        if authStateHandler == nil {
          authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
              if self.user != nil{
                  self.uid = Auth.auth().currentUser?.uid ?? ""
                  self.isLogin = true
              }
              else{
                  self.isLogin = false
              }
          }
        }
      }
    
    func signInWithEmail() async ->  Bool{
        Auth.auth().signIn(withEmail: self.email, password: self.password){
            (result, error) in
            if error != nil{
                self.isValid = true
                self.errorMessage = error!.localizedDescription
            }
            else{
                self.isLogin = true
            }
        }
        return self.isValid
    }
    
    func signUpWithEmail() async -> Bool{
        Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil {
                self.isValid = true
                self.errorMessage = error!.localizedDescription
            }
            else{
                self.uid = Auth.auth().currentUser?.uid ?? ""
                /*
                self.uploadProfileImage()
                self.updateProfile()
                 */
            }
        }
        return self.isValid
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.isLogin = false
            
        } catch let error as NSError {
            self.isValid = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    func changePassword(){
        do{
            try Auth.auth().sendPasswordReset(withEmail: self.email)
        }
        catch{
            self.isValid = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    func uploadProfileImage(){
        guard let data = self.selectedPhotoData else {
            self.errorMessage = "請上傳有效圖片"
            self.isValid = false
            return
        } // Checks whether there is actual data to upload.
        
        let storageRef = Storage.storage().reference()
        //TODO: Replace it with ID
        if let user = Auth.auth().currentUser{
            let fileRef = storageRef.child("\(user.uid)/Profile.png")
            let uploadTask = fileRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
             }
        }
    }
        
    func updateProfile() -> Bool{
        let storageRef = Storage.storage().reference()
        if let user = Auth.auth().currentUser{
            let changeRequest = user.createProfileChangeRequest()
            //changeRequest.photoURL =  URL(string: "gs://travel-63e91.appspot.com/\(user.uid)/Profile.png")
            changeRequest.displayName = self.nickname
            changeRequest.commitChanges{ error in
                if error != nil{
                    self.errorMessage = error!.localizedDescription
                    self.isValid = false
                }
                else{
                    self.isValid = true
                }
            }
        }
        return self.isValid
    }
}
