//
//  SideMenuView.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

protocol RESideMenuViewDelegate: class {
    func didSelectSport(at index: Int)
}

class RESideMenuView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private weak var delegate: RESideMenuViewDelegate?
    private var sports: [RESport] = []
    private let cellID = "RESimpleTableViewCell"
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    final func config(with sports: [RESport], and delegate: RESideMenuViewDelegate?) {
        self.sports = sports
        self.delegate = delegate
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
        let cell: RESimpleTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RESimpleTableViewCell
        
        let title = sports[indexPath.row].name
        
        cell.config(with: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSport(at: indexPath.row)
    }
    
}

