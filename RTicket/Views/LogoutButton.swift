//
//  LogoutButton.swift
//  RTicket
//
//  Created by Andrew Morgan on 28/02/2022.
//

import SwiftUI
import RealmSwift

struct LogoutButton: View {
    @Binding var username: String
    
    @State private var isConfirming = false
    
    var body: some View {
        Button("Logout") { isConfirming = true }
        .confirmationDialog("Are you sure that you want to logout",
                            isPresented: $isConfirming) {
            Button("Confirm Logout", role: .destructive) { logout() }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func logout() {
        Task {
            do {
                try await realmApp.currentUser?.logOut()
                username = ""
            } catch {
                print("Failed to logout: \(error.localizedDescription)")
            }
        }
    }
}
