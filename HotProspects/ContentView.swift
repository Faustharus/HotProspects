//
//  ContentView.swift
//  HotProspects
//
//  Created by Damien Chailloleau on 20/07/2024.
//

import UserNotifications
import SwiftUI

struct ContentView: View {
    
    @State private var output: String = ""
    
    var body: some View {
        VStack {
            List {
                Text(output)
                    .task {
                        await fetchReadings()
                    }
                
                Text("Taylor Swift")
                    .swipeActions {
                        Button("Delete", systemImage: "minus.circle", role: .destructive) {
                            print("Deleting")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button("Pin", systemImage: "pin") {
                            print("Pinning")
                        }
                        .tint(.orange)
                    }
            }
            .padding()
            
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat !"
                content.subtitle = "It looks hungry"
                content.badge = 1
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func fetchReadings() async {
        let final = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let readings = await final.result
        
        switch readings {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error Detected: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
