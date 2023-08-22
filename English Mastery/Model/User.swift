

import SwiftUI
import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let selectedDate: Date
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, name: "David Welson", email: "David_Welson2020@gmail.com", selectedDate: Date())
}
