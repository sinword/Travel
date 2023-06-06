    //
    //  MainView.swift
    //  Travel
    //
    //  Created by 新翌王 on 2023/6/7.
    //

    import SwiftUI

    struct MainView: View {
        static let lemonGreen = Color("ThemeGreen")
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("Travel")
                        .font(Font.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.leading, 35)
                        Spacer()
                }
                .padding(.top, 25)
                // a big green button
                //padding(.bottom, 20)
                
                newTripButtonView.padding(.leading, 10)
            }
            Spacer()
            
            
            tabView
            
        }
        var newTripButtonView: some View {
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("New Trip")
                            .font(.system(size: 30))
                        
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 105)
                .background(MainView.lemonGreen)
                .cornerRadius(15)
                .shadow(radius: 4, x: 0, y: 2)
                Spacer()
            }
            
        }
        
        var tabView: some View {
            TabView {
                Text("")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                Text("")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

                Text("")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                    }

                Text("")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
    }

    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
