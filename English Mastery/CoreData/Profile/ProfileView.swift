//
//  ProfileView.swift
//  English Mastery
//
//  Created by mac on 20.06.2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var birthdate = Date()

    var body: some View {
        
        
        List(){
            Section{
                HStack{
                    Text (User.MOCK_USER.initials)
                        .font (.title)
                        .fontWeight (.semibold)
                        . foregroundColor(.white)
                        .frame(width: 72, height: 72) .background(Color("Color"))
                        .clipShape (Circle ())
                    VStack(alignment: .leading, spacing:4){
                        Text(User.MOCK_USER.name)
                            .bold()
                            .padding(.top, 4)
                        Text(User.MOCK_USER.email)
                            .padding(.top, 4)
                            .italic()
                            .bold()
                            .font(.footnote)
                            .accentColor(.orange)
                        DatePicker(" Birthday:", selection: $birthdate, displayedComponents: .date)
                                            .foregroundColor(.white)
                                            .bold()
                                            .background(Color("Color"))
                                            .cornerRadius(12)


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
                    print("Sign out..")
                }label: {
                    DataView(imageName: "clear.fill", title: "Delete account", colour: Color("Color 4"))
                }
                
                
                
                Button{
                    print("Delete my account")
                }label: {
                    DataView(imageName: "arrowshape.turn.up.left.fill", title: "Sign out", colour: Color("Color 4"))
                }
            }
        }
    }
}
        


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
