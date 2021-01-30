//
//  REEndpoint.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/01/2021.
//

import Foundation

class REEndpoint {
    private static let base = "https://student-sport-results.herokuapp.com/api/"
    
    /// GET: https://student-sport-results.herokuapp.com/api/sports/filter
    static var filterSports = URL(string: base + "sports/filter")!
    
    /// GET: https://student-sport-results.herokuapp.com/api/matches/filter/:sportId
    static var filterMatches = URL(string: base + "matches/filter/")!
    
    /// GET: https://student-sport-results.herokuapp.com/api/matches/get/:matchId
    static var getMatch = URL(string: base + "matches/get/")!
    
    /// GET: https://student-sport-results.herokuapp.com/api/faculties/filter
    static var filterFaculties = URL(string: base + "faculties/filter")!
    
    /// GET: https://student-sport-results.herokuapp.com/api/teams/filter
    static var filterTeams = URL(string: base + "teams/filter")!
    
    /// GET: https://student-sport-results.herokuapp.com/api/players/filter
    static var filterPlayers = URL(string: base + "players/filter")!
}
