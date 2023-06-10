//
//  InfoView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import Firebase

struct InfoView: View {
    
    var body: some View {
        NavigationStack(){
            VStack{
                Text("InfoView")
                Button(action: {logout()}){
                    Text("登出")
                        .frame(width: 60)
                        .padding(10)
                }
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
            }
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            print("Log out!")
        }
        catch { print("already logged out") }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
