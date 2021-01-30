//
//  REMatchDetailsViewController.swift
//  Results
//
//  Created by Benjamin Mecanović on 17/12/2020.
//

import UIKit

class REMatchDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: REMatchDetailsViewModel!
    private let cellID = "REEventTableViewCell"
    var matchId: Int!
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var teamOneButton: UIButton!
    @IBOutlet weak var teamTwoButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
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
        viewModel = REMatchDetailsViewModel(delegate: self, matchId: matchId)
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
        teamOneButton.layer.cornerRadius = 12
        teamTwoButton.layer.cornerRadius = 12
        
        navigationItem.title = "Match details"
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    @IBAction func teamOneButtonTapped(_ sender: Any) {
        REPresenter.showTeamDetailsViewController(onTopOf: self, for: viewModel.match.teamOne)
    }
    
    @IBAction func teamTwoButtonTapped(_ sender: Any) {
        REPresenter.showTeamDetailsViewController(onTopOf: self, for: viewModel.match.teamTwo)
    }
    
}

extension REMatchDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.match?.events.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! REEventTableViewCell
        let event = viewModel.eventForRow(at: indexPath)
        let playerName = viewModel.playerNameForEvent(event)
        let teamName = event.teamId == viewModel.match.teamOneId ? viewModel.match.teamOne.name : viewModel.match.teamTwo.name

        cell.config(time: event.time , part: event.interval.description, eventName: event.type?.name ?? "", playerName: playerName ?? "", teamName: teamName)
        return cell
    }
}

extension REMatchDetailsViewController: RENetworkRequestableDelegate {
    func didStartFetch() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.activityIndicator.startAnimating()
        }
    }
    
    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.teamOneButton.setTitle(welf.viewModel.match.teamOne.name, for: .normal)
            welf.teamTwoButton.setTitle(welf.viewModel.match.teamTwo.name, for: .normal)
            welf.resultLabel.text = welf.viewModel.match.score
            welf.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}
