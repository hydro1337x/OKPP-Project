//
//  RETeamDetailsViewController.swift
//  Results
//
//  Created by Benjamin Mecanović on 30/01/2021.
//

import UIKit

class RETeamDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: RETeamDetailsViewModel!
    private let cellID = "RESimpleTableViewCell"
    var team: RETeam!
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        ai.style = .large
        ai.center = view.center
        ai.color = REColor.main
        self.view.addSubview(ai)
        view.bringSubviewToFront(ai)
        return ai
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        viewModel = RETeamDetailsViewModel(delegate: self, team: team)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        
        view.backgroundColor = .white
        
        navigationItem.title = team.name
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
}

extension RETeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RESimpleTableViewCell
        cell.config(with: viewModel.playerForRow(at: indexPath).name)
        return cell
    }
}

extension RETeamDetailsViewController: RENetworkRequestableDelegate {
    func didStartFetch() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.activityIndicator.startAnimating()
        }
    }
    
    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}
