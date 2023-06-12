    //
    //  AuthModel.swift
    //  Travel
    //
    //  Created by  陳奕軒 on 2023/6/10.
    //

    import Foundation
    import Firebase
    import FirebaseStorage

    @MainActor class AuthModel: ObservableObject{
        var email = ""
        var password = ""
        var confirmPassword = ""
        var nickname = ""
        var profileURL = URL(string: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2Fe6496bba-3356-11ec-91da-063c6e372e74.jpg?crop=2667%2C1500%2C0%2C0")
        
        @Published var selectedPhotoData: Data? = UIImage(systemName: "person.circle.fill")?.pngData() //Default
        
        @Published var isValid = true
        @Published var errorMessage = ""
        @Published var isSignUp = false
        
        @Published var isLogin = false
        @Published var user: User?

        
        init(){
            if Auth.auth().currentUser != nil{
                user = Auth.auth().currentUser
                isLogin = true
            }
            //registerAuthStateHandler()
        }
        
        func updateUser(){
            if Auth.auth().currentUser != nil{
                user = Auth.auth().currentUser
            }
        }
        
        /*
        private var authStateHandler: AuthStateDidChangeListenerHandle?

          func registerAuthStateHandler() {
            if authStateHandler == nil {
              authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                  self.user = user
                  if self.user != nil && !self.isSignUp{
                      //self.uid = Auth.auth().currentUser?.uid ?? ""
                      self.isLogin = true
                  }
                  else{
                      self.isLogin = false
                  }
              }
            }
          }
         */
        
        func signInWithEmail() async ->  Bool{
            Auth.auth().signIn(withEmail: self.email, password: self.password){
                (result, error) in
                if error != nil{
                    self.isValid = false
                    self.errorMessage = error!.localizedDescription
                }
                else{
                    self.user = Auth.auth().currentUser
                    self.isLogin = true
                }
            }
            return self.isValid
        }
        
        func uploadImage() async -> URL{
            guard let data = self.selectedPhotoData else {
                self.errorMessage = "請上傳有效圖片"
                self.isValid = false
                return URL(string: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2Fe6496bba-3356-11ec-91da-063c6e372e74.jpg?crop=2667%2C1500%2C0%2C0")!
            } // Checks whether there is actual data to upload.
            do{
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child("\(self.user!.uid)/Profile.png")
                try await fileRef.putDataAsync(data)
                let url = try await fileRef.downloadURL()
                return url
            }catch{
                print(error)
                return URL(string: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2Fe6496bba-3356-11ec-91da-063c6e372e74.jpg?crop=2667%2C1500%2C0%2C0")!
            }
        }
        
        func updateProfile(url: URL) async{
            let changeRequest = self.user!.createProfileChangeRequest()
            changeRequest.photoURL =  url
            changeRequest.displayName = self.nickname
            do{
                try await changeRequest.commitChanges()
                let ref = Database.database().reference()
                try await ref.child("User/\(self.user!.uid)/displayName").setValue(self.nickname)
                try await ref.child("User/\(self.user!.uid)/email").setValue(self.email)
                try await ref.child("User/\(self.user!.uid)/photoURL").setValue(url.absoluteString)
                try await ref.child("User/\(self.user!.uid)/note").setValue("It is a note.")
            }
            catch{
                self.isValid = false
            }
            
        }
        
        
        func signUpWithEmail() async -> Bool{
            do{
                let result = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
                self.user = result.user
                let url = try await self.uploadImage()
                try await self.updateProfile(url: url)
                self.isValid = true
                self.isSignUp = true
                return true
            } catch{
                self.isValid = false
                self.isSignUp = false
                self.errorMessage = error.localizedDescription
                return false
            }
        }
        /*
        func signUpWithEmail() async -> Bool{
            Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                if error != nil {
                    self.isValid = false
                    self.errorMessage = error!.localizedDescription
                }
                else{
                    self.user = result?.user
                    
                    guard let data = self.selectedPhotoData else {
                        self.errorMessage = "請上傳有效圖片"
                        self.isValid = false
                        return
                    } // Checks whether there is actual data to upload.
                    
                    let storageRef = Storage.storage().reference()
                    //TODO: Replace it with ID
                    let fileRef = storageRef.child("\(self.user!.uid)/Profile.png")
                    let uploadTask = fileRef.putData(data, metadata: nil) { (metadata, error) in
                        guard let metadata = metadata else {
                            return
                        }
                        let changeRequest = self.user!.createProfileChangeRequest()
                        
                        let profileRef = storageRef.child("\(self.user!.uid)/Profile.png")
                        profileRef.downloadURL { url, error in
                            if let error = error {
                                self.errorMessage = error.localizedDescription
                                self.isValid = false
                            } else {
                                changeRequest.photoURL =  url
                                changeRequest.displayName = self.nickname
                                changeRequest.commitChanges{ error in
                                    if error != nil{
                                        self.errorMessage = error!.localizedDescription
                                        self.isValid = false
                                    }
                                    else{
                                        let ref = Database.database().reference()
                                        ref.child("User/\(self.user!.uid)/displayName").setValue(self.nickname)
                                        ref.child("User/\(self.user!.uid)/email").setValue(self.email)
                                        ref.child("User/\(self.user!.uid)/photoURL").setValue(url?.absoluteString)
                                        self.isValid = true
                                        self.isSignUp = true
                                    }
                                }
                            }
                        }
                     }

                }
            }
            return self.isValid
        }
         */
        
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
    }
