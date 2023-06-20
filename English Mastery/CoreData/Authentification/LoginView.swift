//
//  LoginView.swift
//  English Mastery
//
//  Created by mac on 19.06.2023.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                                   .fill(Color("background"))
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 12)
                                           .stroke(Color("Color 4"), lineWidth: 4)
                                   )
                                   .ignoresSafeArea(.all)
                VStack {
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 220)
                        .padding(.vertical,32)
                    VStack(spacing: 1) {
                        InputView(text:$email,
                                  title: "Email Address",
                                  placeholder: "mastery@gmail.com",
                                  isSecureField: false)
                            .autocapitalization(.none)
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: false)

                                }
                    .padding(.horizontal)
                    .padding(.top,4)
                    Button {
                    print("User is loged in")
                    } label:{
                        HStack{
                            Text("SIGN IN")
                            
                                .bold()
                                .foregroundColor(.white)
                                .font(.headline)
                            Image ( systemName:
                            "arrow.right")
                            .foregroundColor(.white)

                            
                        }
                        .frame(width: UIScreen.main.bounds.width-62, height: 54)

                    }
                    .background(Color("Color"))
                    .cornerRadius(18)

                           Spacer()
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 2){
                            Text ("Don't have an account?")
                                .foregroundColor(Color("Color"))

                            Text("Sign up")
                                .bold()
                                .foregroundColor(Color("Color 4"))
                            
                        }
                    }
                }
                    
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()

        }
    }
