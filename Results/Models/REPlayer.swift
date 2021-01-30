//
//  REPlayer.swift
//  Results
//
//  Created by Benjamin Mecanović on 20/01/2021.
//

import Foundation
import SwiftyJSON

class REPlayer {
    let id: Int
    let teamId: Int
    let name: String
    let createdAt: Date = Date()
    let updatedAt: Date = Date()
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.teamId = json["team_id"].intValue
        self.name = json["name"].stringValue
    }
}
