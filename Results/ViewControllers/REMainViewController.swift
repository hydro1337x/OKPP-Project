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
    
    // MARK: - Outlets
    @IBOutlet private weak var sideMenuView: RESideMenuView!
    @IBOutlet private weak var menuWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        viewModel = REMainViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        sideMenuView.config(with: viewModel.titles, iconNames: viewModel.iconNames)
        menuWidthConstraint.constant = horizontalMenuTranslation
    }
    
    // MARK: - Actions
    @objc private func handleLeftBarButtonItemTap(_ sender: UIButton) {
        let translation = CGAffineTransform(translationX: menuShown ? 0 : -horizontalMenuTranslation, y: 0)
        menuShown = !menuShown
        
        sideMenuView.layer.setAffineTransform(translation)
    }
    
    // MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = "Sports"
        let image = UIImage(systemName: "list.bullet")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLeftBarButtonItemTap(_:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

}
