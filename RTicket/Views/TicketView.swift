//
//  TicketView.swift
//  RTicket
//
//  Created by Griffin Velichko on 2024-08-24.
//

import SwiftUI
import RealmSwift

struct TicketView: View {
    @ObservedRealmObject var ticket: Ticket
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text(ticket.title)
                    .font(.headline)
                    .foregroundStyle(ticket.color)
                Spacer()
                DateView(date: ticket.created)
                    .font(.caption)
            }
            Text(ticket.author)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(ticket.details ?? "No details")
                .font(.caption)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            if ticket.status == .inProgress {
                Button(action: { $ticket.status.wrappedValue = .notStarted }) {
                    Label("Not Started", systemImage: "stop.circle.fill")
                }
                .tint(.red)
            }
            if ticket.status == .complete {
                Button(action: { $ticket.status.wrappedValue = .inProgress }) {
                    Label("In Progress", systemImage: "bolt.circle.fill")
                }
                .tint(.yellow)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if ticket.status == .inProgress {
                Button(action: { $ticket.status.wrappedValue = .complete }) {
                    Label("Complete", systemImage: "checkmark.circle.fill")
                }
                .tint(.green)
            }
            if ticket.status == .notStarted {
                Button(action: { $ticket.status.wrappedValue = .inProgress }) {
                    Label("In Progress", systemImage: "bolt.circle.fill")
                }
                .tint(.yellow)
            }
        }
    }
}
