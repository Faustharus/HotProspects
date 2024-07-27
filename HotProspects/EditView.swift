//
//  EditView.swift
//  HotProspects
//
//  Created by Damien Chailloleau on 26/07/2024.
//

import SwiftData
import SwiftUI

struct EditView: View {
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $prospect.name)
            }
            
            Section("Email Address") {
                TextField("Email Address", text: $prospect.emailAddress)
            }
            
            Section("Contacted ?") {
                Toggle(isOn: $prospect.isContacted) {
                    Text(prospect.isContacted ? "Has been conatcted" : "Is not yet contacted")
                }
                .padding(.horizontal, 40)
            }
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect.example
        return EditView(prospect: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
