//
//  RESideMenuTableViewCell.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

class RESideMenuTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    final func config(with title: String?, and imageName: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: imageName)
    }
    
}
