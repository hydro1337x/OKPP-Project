//
//  SideMenuView.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

class RESideMenuView: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var iconNames: [String] = []
    private var titles: [String] = []
    private let cellID = "RESideMenuTableViewCell"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RESideMenuTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    final func config(with titles: [String], iconNames: [String]) {
        self.iconNames = iconNames
        self.titles = titles
    }

}

extension RESideMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? RESideMenuTableViewCell else { return UITableViewCell()}
        
        let title = titles[indexPath.row]
        let iconName = iconNames[indexPath.row]
        
        cell.config(with: title, and: iconName)
        
        return cell
    }
    
    
}

