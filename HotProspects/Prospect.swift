//
//  Prospect.swift
//  HotProspects
//
//  Created by Damien Chailloleau on 23/07/2024.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded = Date.now
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
    
    #if DEBUG
    static let example = Prospect(name: "Jane Doe", emailAddress: "jane@hackingwithswift.com", isContacted: false)
    #endif
}
