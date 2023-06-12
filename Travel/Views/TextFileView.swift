//
//  TextFileView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/12.
//

import Foundation
import SwiftUI

struct TextFileView: View {
    @State var fileName: String = ""
    @State var content: String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Text(self.fileName)
                    .font(Font.system(size: 40))
                    .fontWeight(.bold)
                    //.padding(.leading, 35)
                    Spacer()
            }.padding(.bottom, 20)
            HStack{
                Text(self.content)
                Spacer()
            }.padding(.leading, 10)
            Spacer()
        }.onAppear{
            if let path = Bundle.main.path(forResource: self.fileName, ofType: "txt",
                                           inDirectory: "textFolder"){
                do{
                    self.content = try String(contentsOfFile: path, encoding: .utf8)
                    print(self.content)
                }catch{
                    print("File \(self.fileName) does not exist!")
                    return
                }
            }

        }.padding(20)
    }
}

struct TextFileView_Previews: PreviewProvider {
    static var previews: some View {
        TextFileView(fileName: "test")

    }
}


