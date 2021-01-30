//
//  REEvent.swift
//  Results
//
//  Created by Benjamin Mecanović on 20/01/2021.
//

import Foundation
import SwiftyJSON

class REEvent {
    
    enum EventType: String {
        case goal = "goal"
        case yellowCard = "yellow_card"
        case redCard = "red_card"
        case penaltyKick = "penalty_kick"
        
        var name: String {
            switch self {
            case .goal:
                return "Goal"
            
            case .penaltyKick:
                return "Penalty"
                
            case .redCard:
                return "Red card"
                
            case .yellowCard:
                return "Yellow card"
            }
        }
    }
    
    let matchId: Int
    let teamId: Int
    let playerId: Int
    let type: EventType?
    let time: String
    let interval: Int
    
    init(json: JSON) {
        self.matchId = json["match_id"].intValue
        self.teamId = json["team_id"].intValue
        self.playerId = json["player_id"].intValue
        self.type = EventType(rawValue: json["type"].stringValue)
        self.time = Int(json["time"].doubleValue / 100000).description
        self.interval = json["interval"].intValue
    }
    
}
