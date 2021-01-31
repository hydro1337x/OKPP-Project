//
//  REEventTableViewCell.swift
//  Results
//
//  Created by Benjamin Mecanović on 20/01/2021.
//

import UIKit

class REEventTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var partLabel: UILabel!
    @IBOutlet private weak var eventLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var teamLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        prepareUI()
    }
    
    // MARK: - Internal Config
    private func setupUI() {}
    
    private func prepareUI() {}
    
    // MARK: - Public Config
    final func config(time: String, part: String, eventName: String, playerName: String, teamName: String ) {
        
        if REEvent.EventType(rawValue: eventName) == REEvent.EventType.gameEnd {
            self.timeLabel.text = eventName
            self.partLabel.text = ""
            self.eventLabel.text = ""
            self.nameLabel.text = ""
            self.teamLabel.text = ""
        } else {
            self.timeLabel.text = time + "'"
            self.partLabel.text = "(Part " + part + ")"
            self.eventLabel.text = eventName
            self.nameLabel.text = playerName
            self.teamLabel.text = "(" + teamName + ")"
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods

    
}
