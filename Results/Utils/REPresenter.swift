//
//  REPresenter.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

struct REPresenter {
    static func showMatchDetailsViewController(onTopOf topViewController: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: String(describing: REMatchDetailsViewController.self))
        
        topViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
