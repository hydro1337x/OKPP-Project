//
//  REMainViewController.swift
//  Results
//
//  Created by Benjamin Mecanović on 15/12/2020.
//

import UIKit

class REMainViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: REMainViewModel!
    private var menuHidden = true
    private let horizontalMenuTranslation: CGFloat = 2 * UIScreen.main.bounds.width / 3
    private let cellID = "REMatchTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sideMenuView: RESideMenuView!
    @IBOutlet private weak var dimmView: UIView!
    @IBOutlet private weak var menuWidthConstraint: NSLayoutConstraint!
    
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
        viewModel = REMainViewModel(with: self)
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
        
        setupNavigationBar()
        
        menuWidthConstraint.constant = horizontalMenuTranslation
        
        sideMenuView.layer.setAffineTransform(CGAffineTransform(translationX: -horizontalMenuTranslation, y: 0))
        
        
    }
    
    // MARK: - Actions
    @objc private func handleLeftBarButtonItemTap() {
        let translation = CGAffineTransform(translationX: menuHidden ? 0 : -horizontalMenuTranslation, y: 0)
        menuHidden = !menuHidden
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.sideMenuView.layer.setAffineTransform(translation)
            self.dimmView.alpha = self.dimmView.alpha == 0 ? 0.5 : 0
        }, completion: nil)
    }
    
    // MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = "Sports"
        let image = UIImage(systemName: "list.bullet")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLeftBarButtonItemTap))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

}

extension REMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! REMatchTableViewCell
        let match = viewModel.matchForRow(at: indexPath.row)
        cell.config(firstTeamName: match.teamOne.name, secondTeamName: match.teamTwo.name, score: match.score)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        REPresenter.showMatchDetailsViewController(onTopOf: self, with: viewModel.matchForRow(at: indexPath.row).id)
    }
}

extension REMainViewController: RENetworkRequestableDelegate {
    func didStartFetch() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.activityIndicator.startAnimating()
        }
    }
    
    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.title = welf.viewModel.matches.first?.sport.name
            welf.sideMenuView.config(with: welf.viewModel.sports, and: self)
            welf.tableView.reloadData()
            welf.sideMenuView.reloadTableView()
            self?.activityIndicator.stopAnimating()
        }
    }
}

extension REMainViewController: RESideMenuViewDelegate {
    func didSelectSport(at index: Int) {
        viewModel.fetchMatches(for: viewModel.sportForRow(at: index).id.description)
    }
}
