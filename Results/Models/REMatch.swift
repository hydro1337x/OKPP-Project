//
//  REMatch.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/01/2021.
//

import Foundation
import SwiftyJSON

class REMatch {
    let id: Int
    let sportId: Int
    let teamOneId: Int
    let teamTwoId: Int
    let date: Date = Date()
    let createdAt: Date = Date()
    let updatedAt: Date = Date()
    let sport: RESport
    let teamOne: RETeam
    let teamTwo: RETeam
    let score: String
    var events: [REEvent] = []
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.sportId = json["sport_id"].intValue
        self.teamOneId = json["team_one"].intValue
        self.teamTwoId = json["team_two"].intValue
        self.sport = RESport(json: json["sport"])
        self.teamOne = RETeam(json: json["teamOne"])
        self.teamTwo = RETeam(json: json["teamTwo"])
        self.score = json["score"].stringValue
        json["events"].arrayValue.forEach {
            let event = REEvent(json: $0)
            events.append(event)
        }
    }
}
