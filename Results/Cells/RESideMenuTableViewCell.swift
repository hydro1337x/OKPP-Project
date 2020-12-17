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
    
    // MARK: - Properties
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        contentView.backgroundColor = REColor.main
    }
    
    final func config(with title: String?, and imageName: String) {
        self.titleLabel.text = title
        self.iconImageView.image = UIImage(systemName: imageName)
    }
    
}
