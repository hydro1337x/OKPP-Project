//
//  REMainViewModel.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import Foundation
import SwiftyJSON

protocol RENetworkRequestableDelegate: class {
    func didFetchData()
    func didStartFetch()
}

class REMainViewModel {
    
    // MARK: - Properties
    var iconNames = ["house", "house", "house"]
    private weak var delegate: RENetworkRequestableDelegate?
    var sports: [RESport] = []
    var matches: [REMatch] = []
    private var didFetchSports: Bool = false {
        didSet {
            if didFetchSports == true {
                fetchMatches()
            }
        }
    }
    
    // MARK: - Init
    init(with delegate: RENetworkRequestableDelegate?) {
        self.delegate = delegate
        fetchSports()
    }
    
    // MARK: - Methods
    private func fetchSports() {
        sports.removeAll()
        delegate?.didStartFetch()
        URLSession.shared.dataTask(with: REEndpoint.filterSports) { [weak self] (data, _, error) in
            guard let welf = self else { return }
            if let data = data, let json = try? JSON(data: data) {
                json["data"].arrayValue.forEach {
                    let sport = RESport(json: $0)
                    welf.sports.append(sport)
                }
                welf.didFetchSports = true
            } else {
                print("Error: ", error?.localizedDescription as Any)
            }
        }.resume()
    }
    
    func fetchMatches(for sportId: String? = nil) {
        matches.removeAll()
        delegate?.didStartFetch()
        var sid: String?
        if let sportId = sportId {
            sid = sportId
        } else {
            sid = sports.first?.id.description
        }
        guard let sportsID = sid else { return }
        let finalURL = REEndpoint.filterMatches.appendingPathComponent(sportsID)
        URLSession.shared.dataTask(with: finalURL) { [weak self] (data, _, error) in
            guard let welf = self else { return }
            if let data = data, let json = try? JSON(data: data) {
                json["data"].arrayValue.forEach {
                    let match = REMatch(json: $0)
                    welf.matches.append(match)
                }
                welf.delegate?.didFetchData()
            } else {
                print("Error: ", error?.localizedDescription as Any)
            }
        }.resume()
    }
    
    final func sportForRow(at index: Int) -> RESport {
        return sports[index]
    }
    
    final func matchForRow(at index: Int) -> REMatch {
        return matches[index]
    }
    
}
