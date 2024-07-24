//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Damien Chailloleau on 20/07/2024.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
