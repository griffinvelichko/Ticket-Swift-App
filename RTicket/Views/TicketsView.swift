//
//  TicketsView.swift
//  RTicket
//
//  Created by Griffin Velichko on 2024-08-24.
//

import SwiftUI
import RealmSwift

struct TicketsView: View {
    @ObservedResults(Ticket.self, sortDescriptor: SortDescriptor(keyPath: "status", ascending: false)) var tickets
    @Environment(\.realm) var realm
    
    let username: String
    let product: String
    
    @State private var busy = false
    @State private var title = ""
    @State private var details = ""
    @State private var searchText = ""
    
    var body: some View {
        let filteredTickets = tickets.where { ticket in
            ticket.title.contains(searchText, options: .caseInsensitive) || ticket.details.contains(searchText, options: .caseInsensitive)
        }
        return ZStack {
            VStack {
                List {
                    ForEach(searchText.isEmpty ? tickets : filteredTickets) { ticket in
                        TicketView(ticket: ticket)
                    }
                }
                .searchable(text: $searchText)
                Spacer()
                VStack {
                    TextField("Title", text: $title)
                    TextField("Details", text: $details)
                        .font(.caption)
                    Button("Add Ticket") {
                        addTicket()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || busy)
                }
            }
            .padding()
            if busy {
                ProgressView()
            }
        }
        .onAppear(perform: {
            subscribe()
        })
        .onDisappear(perform: {
            unsubscribe()
        })
        .navigationTitle(product).navigationBarTitleDisplayMode(.inline)
    }
    
    private func addTicket() {
        let ticket = Ticket(product: product, title: title, details: details.isEmpty ? nil : details, author: username)
        $tickets.append(ticket)
        title = ""
        details = ""
    }
    
    private func subscribe() {
        let lastYear = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate.rounded() - (60 * 60 * 24 * 365))
        let subscriptions = realm.subscriptions
        if subscriptions.first(named: product) == nil {
            busy = true
            subscriptions.update {
                subscriptions.append(QuerySubscription<Ticket>(name: product) {ticket in
                    return ticket.product == product && (
                        ticket.status != .complete || ticket.created > lastYear
                    )
                })
            } onComplete: { error in
                if let error = error {
                    print("Failed to subscribe for \(product): \(error.localizedDescription)")
                }
                busy = false
            }
        }
    }
    
    private func unsubscribe() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.remove(named: product)
        } onComplete: { error in
            if let error = error {
                print("Failed to unsubscribe for \(product): \(error.localizedDescription)")
            }
        }
    }
}
