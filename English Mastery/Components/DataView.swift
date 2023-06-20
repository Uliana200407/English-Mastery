//
//  DataView.swift
//  English Mastery
//
//  Created by mac on 20.06.2023.
//

import SwiftUI

struct DataView: View {
    let imageName: String
    let title: String
    let birthdate = Date()
    let colour: Color
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .foregroundColor(Color("Color 4"))
                .font(.title)
                .foregroundColor(Color.black)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(imageName: "gear", title: "Version", colour: Color("Color 4"))
    }
}
