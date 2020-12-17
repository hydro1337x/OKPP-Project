//
//  SideMenuView.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

class RESideMenuView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var iconNames: [String] = []
    private var titles: [String] = []
    private let cellID = "RESideMenuTableViewCell"
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("RESideMenuView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = REColor.main
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RESideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
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
        let cell: RESideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RESideMenuTableViewCell
        
        let title = titles[indexPath.row]
        let iconName = iconNames[indexPath.row]
        
        cell.config(with: title, and: iconName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

