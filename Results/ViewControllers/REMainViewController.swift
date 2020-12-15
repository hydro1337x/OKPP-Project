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
        setupNavigationBar()
    }
    
    // MARK: - Actions
    @objc private func handleLeftBarButtonItemTap(_ sender: UIButton) {
        // Handle opening
    }
    
    // MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = "Sports"
        let image = UIImage(systemName: "list.bullet")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLeftBarButtonItemTap(_:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

}
