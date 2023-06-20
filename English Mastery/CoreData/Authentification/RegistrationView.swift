//
//  RegistrationView.swift
//  English Mastery
//
//  Created by mac on 20.06.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var password = ""
    @State private var email = ""
    @State private var name = ""
    @State private var birthdate = Date()
    @State private var isDatePickerVisible = false // Added state for DatePicker visibility
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        .frame(width: 200, height: 220)
                        .padding(.vertical, 32)
                    
                    VStack(spacing: 3) {
                        InputView(text: $name,
                                  title: "Name",
                                  placeholder: "Enter your name",
                                  isSecureField: false)
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "mastery@gmail.com",
                                  isSecureField: false)
                            .autocapitalization(.none)
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: false)
                        
                        Button(action: {
                            isDatePickerVisible = true
                        }) {
                            HStack {
                                Text(" Age:")
                                    .foregroundColor(Color("Color 4"))
                                    .font(.title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                TextField("Birthdate",
                                          value: $birthdate,
                                          formatter: dateFormatter)
                                    .foregroundColor(.black)
                                    .frame(height: 40)
                                    .padding(.horizontal)
                                    .background(Color("TextField"))
                                    .border(Color("Color 4"))
                                    .disabled(true)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width-62, height: 54)
                        .buttonStyle(PlainButtonStyle())
                        Divider()

                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        print("User is signed up")
                    }) {
                        HStack{
                            Text("SIGN UP")
                                .bold()
                                .foregroundColor(.white)
                                .font(.headline)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width - 62, height: 54)
                    }
                    .background(Color("Color"))
                    .cornerRadius(18)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 2){
                            Text("Already have an account?")
                                .foregroundColor(Color("Color"))
                            Text("Sign in")
                                .bold()
                                .foregroundColor(Color("Color 4"))
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isDatePickerVisible){
            DatePicker("", selection: $birthdate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .foregroundColor(.black)
                .bold()
                .padding(.top, 8)
                .onDisappear {
                    isDatePickerVisible = false
                }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
