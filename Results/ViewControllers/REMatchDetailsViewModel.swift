//
//  REMatchDetailsViewModel.swift
//  Results
//
//  Created by Benjamin Mecanović on 20/01/2021.
//

import Foundation
import SwiftyJSON

class REMatchDetailsViewModel {
    
    // MARK: - Properties
    private var matchId: Int!
    var match: REMatch!
    private weak var delegate: RENetworkRequestableDelegate?
    
    // MARK: - Init
    init(delegate: RENetworkRequestableDelegate?, matchId: Int) {
        self.delegate = delegate
        self.matchId = matchId
        fetchMatchDetails()
    }
    
    // MARK: - Methods
    private func fetchMatchDetails() {
        let finalURL = REEndpoint.getMatch.appendingPathComponent(matchId.description)
        delegate?.didStartFetch()
        URLSession.shared.dataTask(with: finalURL) { [weak self] (data, _, error) in
            guard let welf = self else { return }
            if let data = data, let json = try? JSON(data: data) {
                welf.match = REMatch(json: json["data"])
                welf.delegate?.didFetchData()
            } else {
                print("Error: ", error?.localizedDescription as Any)
            }
        }.resume()
    }
    
    final func eventForRow(at indexPath: IndexPath) -> REEvent {
        return match.events[indexPath.row]
    }
    
    final func playerNameForEvent(_ event: REEvent) -> String? {
        let playerId = event.playerId
        let teamId = event.teamId
        
        if teamId == match.teamOneId {
            return match.teamOne.players.first { $0.id == playerId }?.name
        } else {
            return match.teamTwo.players.first { $0.id == playerId }?.name
        }
    }
    
}
