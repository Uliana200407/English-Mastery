

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthentificationFormProtocol {
    var FormIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    func CreateUser(withEmail email: String, password: String, name: String, selectedDate: Date) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email, selectedDate: selectedDate)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }

    
    func signout () {
         do{
             try Auth.auth().signOut()
             self.userSession = nil
             self.currentUser = nil
         } catch{
             print ("DEBUG: Failed to sign out with error \(error.localizedDescription)")
         }
     }
    
    func deleteAccount() {
        
    }
    
    func fetchUser () async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore() .collection ("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }


}
