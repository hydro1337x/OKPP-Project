//
//  REMainViewModel.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import Foundation
import SwiftyJSON

protocol REMainViewModelDelegate: class {
    func didFetchData()
}

class REMainViewModel {
    
    // MARK: - Properties
    var iconNames = ["house", "house", "house"]
    private weak var delegate: REMainViewModelDelegate?
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
    init(with delegate: REMainViewModelDelegate?) {
        self.delegate = delegate
        fetchSports()
    }
    
    // MARK: - Methods
    private func fetchSports() {
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
    
    private func fetchMatches() {
        guard let firstSportId = sports.first?.id.description else { return }
        let finalURL = REEndpoint.filterMatches.appendingPathComponent(firstSportId)
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
    
}
