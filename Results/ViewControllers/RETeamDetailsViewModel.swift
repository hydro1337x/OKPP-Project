//
//  RETeamDetailsViewModel.swift
//  Results
//
//  Created by Benjamin Mecanović on 30/01/2021.
//

import Foundation
import SwiftyJSON

class RETeamDetailsViewModel {
    
    // MARK: - Properties
    var players: [REPlayer] = []
    
    // MARK: - Init
    init(players: [REPlayer]) {
        self.players = players
    }
    
    // MARK: - Methods
    
    final func playerForRow(at indexPath: IndexPath) -> REPlayer {
        return players[indexPath.row]
    }
    
}
