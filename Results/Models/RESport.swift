//
//  RESport.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/01/2021.
//

import Foundation
import SwiftyJSON

class RESport {
    let id: Int
    let name: String
    let minPlayers: Int
    let createdAt: Date?
    let updatedAt: Date?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.minPlayers = json["minPlayers"].intValue
        let df = DateFormatter()
        createdAt = df.date(from: json["created_at"].stringValue)
        updatedAt = df.date(from: json["updated_at"].stringValue)
    }
}
