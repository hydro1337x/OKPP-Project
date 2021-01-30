//
//  RESimpleTableViewCell.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

class RESimpleTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
    }
    
    final func config(with title: String?) {
        self.titleLabel.text = title
    }
    
}
