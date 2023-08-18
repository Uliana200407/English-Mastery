//
//  ProfileView.swift
//  English Mastery
//
//  Created by mac on 20.06.2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var birthdate = Date()
    @EnvironmentObject var viewModel : AuthViewModel
    @State var selectedTab = ""
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()

    
    var body: some View {
        
        if let user = viewModel.currentUser {
            List(){
                Section{
                    HStack{
                        Text (user.initials)
                            .font (.title)
                            .fontWeight (.semibold)
                            . foregroundColor(.white)
                            .frame(width: 72, height: 72) .background(Color("Color"))
                            .clipShape (Circle ())
                        VStack(alignment: .leading, spacing:4){
                            Text(user.name)
                                .bold()
                                .padding(.top, 4)
                            Text(user.email)
                                .padding(.top, 4)
                                .italic()
                                .bold()
                                .font(.footnote)
                                .accentColor(.orange)
                            Text(dateFormatter.string(from: user.selectedDate))
                                .font(.footnote)
                                .bold()
                                .foregroundColor(Color("Color"))
                                .padding(.bottom, 4)
                        }
                    }
                    
                }
                Section("DATA"){
                    HStack{
                        DataView(imageName: "gear",
                                 title: "Version",
                                 colour: .accentColor)
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(Color("Color 4"))
                    }
                }
                Section("PROFILE"){
                    Button{
                        viewModel.signout()
                    }label: {
                        DataView(imageName: "clear.fill", title: "Sign out", colour: Color("Color 4"))
                    }
                    
                    
                    
                    Button{
                        print("Delete my account")
                    }label: {
                        DataView(imageName: "arrowshape.turn.up.left.fill", title: "Delete account", colour: Color("Color 4"))
                    }
                }
            }
        }
        ZStack(alignment:.bottom, content: {
            CustomTabBar(selectedTab: $selectedTab)

        })
    }
}
        


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
