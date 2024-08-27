//
//  ContentView.swift
//  RTicket
//
//  Created by Griffin Velichko on 2024-08-24.
//

//import SwiftUI
//
//struct ContentView: View {
//    @State private var username = ""
//
//    var body: some View {
//        NavigationView {
//            if (username == "") {
//                EmailLoginView(username: $username)
//            } else {
//                ProductView(username: username)
//                    .toolbar {
//                        ToolbarItem(placement: .topBarTrailing) {
//                            LogoutButton(username: $username)
//                        }
//                    }
//            }
//        }
//    }
//}

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var username: String = realmApp.currentUser?.profile.email ?? ""

    var body: some View {
        NavigationView {
            if username != "" {
                ProductView(username: username)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            LogoutButton(username: $username)
                        }
                    }
            } else {
                EmailLoginView(username: $username)
            }
        }
    }
}
