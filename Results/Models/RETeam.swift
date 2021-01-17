//
//  RETeam.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/01/2021.
//

import Foundation
import SwiftyJSON

class RETeam {
    let id: Int
    let name: String
    let createdAt: Date?
    let updatedAt: Date?
    let facultyId: Int
    let sportId: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.facultyId = json["faculty_id"].intValue
        self.sportId = json["sport_id"].intValue
        let df = DateFormatter()
        self.createdAt = df.date(from: json["created_at"].stringValue)
        self.updatedAt = df.date(from: json["updated_at"].stringValue)
    }
}
