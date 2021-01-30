//
//  REPresenter.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

struct REPresenter {
    static func showMatchDetailsViewController(onTopOf topViewController: UIViewController, with matchId: Int) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: String(describing: REMatchDetailsViewController.self))
        (vc as? REMatchDetailsViewController)?.matchId = matchId
        topViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func showTeamDetailsViewController(onTopOf topViewController: UIViewController, for team: RETeam) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: String(describing: RETeamDetailsViewController.self))
        (vc as? RETeamDetailsViewController)?.team = team
        topViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
