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
    private var menuShown = false
    private let horizontalMenuTranslation: CGFloat = 2 * UIScreen.main.bounds.width / 3
    private let cellID = "REMatchTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sideMenuView: RESideMenuView!
    @IBOutlet private weak var menuWidthConstraint: NSLayoutConstraint!
    
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
        tableView.register(UINib(nibName: "REMatchTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        menuWidthConstraint.constant = horizontalMenuTranslation
    }
    
    // MARK: - Actions
    @objc private func handleLeftBarButtonItemTap(_ sender: UIButton) {
        let translation = CGAffineTransform(translationX: menuShown ? 0 : -horizontalMenuTranslation, y: 0)
        menuShown = !menuShown
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.sideMenuView.layer.setAffineTransform(translation)
        }, completion: nil)
    }
    
    // MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = "Sports"
        let image = UIImage(systemName: "list.bullet")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLeftBarButtonItemTap(_:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

}

extension REMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! REMatchTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        REPresenter.showMatchDetailsViewController(onTopOf: self)
    }
}

extension REMainViewController: REMainViewModelDelegate {
    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.sideMenuView.config(with: welf.viewModel.sports)
            welf.tableView.reloadData()
            welf.sideMenuView.reloadTableView()
        }
    }
}
