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
    private var sports: [RESport] = []
    private let cellID = "RESideMenuTableViewCell"
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Config
    
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
    
    final func config(with sports: [RESport]) {
        self.sports = sports
    }
    
    // MARK: - Methods
    final func reloadTableView() {
        tableView.reloadData()
    }

}

extension RESideMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RESideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RESideMenuTableViewCell
        
        let title = sports[indexPath.row].name
        
        cell.config(with: title, and: "iconName")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

