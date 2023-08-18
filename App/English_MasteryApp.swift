//
//  English_MasteryApp.swift
//  English Mastery
//
//  Created by mac on 18.06.2023.
//

import SwiftUI
import Firebase
@main
struct English_MasteryApp: App {
    @StateObject var viewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
