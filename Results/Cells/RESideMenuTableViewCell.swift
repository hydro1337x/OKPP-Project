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
    private var title: String!
    private var imageName: String!
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: imageName)
    }
    
    final func config(with title: String?, and imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
}
