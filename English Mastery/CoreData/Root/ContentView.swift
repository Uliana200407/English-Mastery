

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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
