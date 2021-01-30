//
//  REMatchTableViewCell.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/12/2020.
//

import UIKit

class REMatchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var firstTeamLabel: UILabel!
    @IBOutlet weak var secondTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    final func config(firstTeamName: String, secondTeamName: String, score: String) {
        self.firstTeamLabel.text = firstTeamName
        self.secondTeamLabel.text = secondTeamName
        self.scoreLabel.text = score
    }
    
}
