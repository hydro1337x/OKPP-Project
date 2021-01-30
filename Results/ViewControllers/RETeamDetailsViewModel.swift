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
    private weak var delegate: RENetworkRequestableDelegate?
    
    // MARK: - Init
    init(delegate: RENetworkRequestableDelegate?, team: RETeam) {
        self.delegate = delegate
        fetchPlayersFor(team.id)
    }
    
    // MARK: - Methods
    private func fetchPlayersFor(_ teamId: Int) {
        players.removeAll()
        delegate?.didStartFetch()
        URLSession.shared.dataTask(with: REEndpoint.filterPlayers) { [weak self] (data, _, error) in
            guard let welf = self else { return }
            if let data = data, let json = try? JSON(data: data) {
                var players: [REPlayer] = []
                json.arrayValue.forEach {
                    let player = REPlayer(json: $0)
                    players.append(player)
                }
                
                let teamPlayers = players.filter { $0.teamId == teamId }
                
                welf.players.append(contentsOf: teamPlayers)
                
                welf.delegate?.didFetchData()
            } else {
                print("Error: ", error?.localizedDescription as Any)
            }
        }.resume()
    }
    
    final func playerForRow(at indexPath: IndexPath) -> REPlayer {
        return players[indexPath.row]
    }
    
}
