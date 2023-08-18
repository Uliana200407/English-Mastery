//
//  ContentView.swift
//  English Mastery
//
//  Created by mac on 18.06.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea(.all)
            Group{
                if viewModel.userSession != nil{
                 ProfileView()
                }else{
                    LoginView()
                }
            }
         
        }
      //  .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
