//
//  REMatchTableViewCell.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/12/2020.
//

import UIKit

class REMatchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var firstTeamLabel: UILabel!
    @IBOutlet private weak var secondTeamLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var separatorLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    final func config(firstTeamName: String, secondTeamName: String, score: String, gameFinished: Bool) {
        self.firstTeamLabel.text = firstTeamName
        self.secondTeamLabel.text = secondTeamName
        self.scoreLabel.text = score
        if gameFinished {
            firstTeamLabel.font = UIFont.boldSystemFont(ofSize: 17)
            secondTeamLabel.font = UIFont.boldSystemFont(ofSize: 17)
            scoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
            separatorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            firstTeamLabel.font = UIFont.systemFont(ofSize: 17)
            secondTeamLabel.font = UIFont.systemFont(ofSize: 17)
            scoreLabel.font = UIFont.systemFont(ofSize: 20)
            separatorLabel.font = UIFont.systemFont(ofSize: 20)
        }
    }
    
}
