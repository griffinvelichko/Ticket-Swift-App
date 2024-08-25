//
//  RTicketApp.swift
//  RTicket
//
//  Created by Andrew Morgan on 25/02/2022.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "application-0-ttsawut")
let useEmailPasswordAuth = true

@main
struct RTicketApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
