//
//  LoginView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/8.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var authModel: AuthModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(){
            VStack{
                Spacer()
                VStack(){
                    HStack(){
                        Text("電子郵件")
                            .fontWeight(.black)
                        Spacer()
                    }
                    TextField("Email", text: $authModel.email)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 30)
                }
                
                VStack(){
                    HStack(){
                        Text("密碼")
                            .fontWeight(.black)
                        Spacer()
                    }
                    SecureField("密碼", text: $authModel.password)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 10)
                }
                
                HStack(){
                    Button(action: resetPassword){
                        Text("忘記密碼？")
                    }
                    Spacer()
                }.padding([.bottom], 20)
                
                HStack(){
                    NavigationLink(destination: RegisterView().environmentObject(authModel)){
                        Text("註冊")
                            .frame(width: 60)
                            .padding(10)
                    }
                    
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(20)
                    .offset(x: 20)
                    
                    
                    Spacer()
                    
                    Button(action: signInWithEmail){
                        Text("登入")
                            .frame(width: 60)
                            .padding(10)
                    }
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(20)
                    .offset(x: -20)
                    .alert(isPresented: !$authModel.isValid){
                        Alert(
                            title: Text("警告"),
                            message: Text(authModel.errorMessage),
                            dismissButton: .default(Text("確認"))
                        )
                    }
                }
                Spacer()
                
            }.padding(20)
                .navigationTitle("登入")
        }
    }
    
    func signInWithEmail(){
        Task{
            if try await authModel.signInWithEmail(){
            }
            else{
            }
        }
    }
    
    func resetPassword(){
        authModel.changePassword()
    }
}


struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}

