//
//  ProductView.swift
//  RTicket
//
//  Created by Griffin Velichko on 2024-08-24.
//

import SwiftUI

struct ProductView: View {
    let username: String
    
    let products = ["MongoDB", "Atlas", "Realm", "Charts", "Compass"]
    
    var body: some View {
        List {
            if let realmUser = realmApp.currentUser {
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: TicketsView(username: username, product: product) .environment(\.realmConfiguration, realmUser.flexibleSyncConfiguration())) {
                            Text(product)
                        }
                }
            }
        }
        .navigationTitle("Products").navigationBarTitleDisplayMode(.inline)
        
    }
}
