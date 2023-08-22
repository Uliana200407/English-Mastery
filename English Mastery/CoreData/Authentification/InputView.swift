

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let isSecureField: Bool
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(title)
                .foregroundColor(Color("Color 4"))
                .bold()
                .font(.footnote)
            
            HStack {
                if isSecureField {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16))
                } else {
                    if isPasswordVisible {
                        TextField(placeholder, text: $text)
                            .font(.system(size: 16))
                    } else {
                        SecureField(placeholder, text: $text)
                            .font(.system(size: 16))
                    }
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(Color("Color 4"))
                }
            }
            .frame(height: 40)
            .padding(.horizontal)
            .background(Color("TextField"))
            .border(Color("Color 4"))
            .frame(maxWidth: .infinity)
            
            Divider()
        }
        .padding()
    }
}



struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email adress", placeholder: "mastery@gmail.com", isSecureField: false)
        
    }
}
