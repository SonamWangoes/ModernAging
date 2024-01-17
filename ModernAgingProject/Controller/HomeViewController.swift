//
//  HomeViewController.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import UIKit
import Combine
import OSLog

class HomeViewController: UIViewController{
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var tableViewheightConstant: NSLayoutConstraint!
    
    private var homeViewModel: HomeViewModel!
    private var dataSource: ArticleTableViewDataSource<ArticleTableViewCell,ArticlesData>!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        self.navigationController?.navigationBar.isHidden = true
        self.articlesTableView.isScrollEnabled = false
        self.homeViewModel = HomeViewModel()
        bindViewModel()
    }
    
    private func bindViewModel() {
        homeViewModel.$articleData
            .sink{ [weak self] _ in
                self?.updateDataSource()
            }.store(in: &cancellables)
    }
    
    // MARK: - DataSource Update
    func updateDataSource(){
        self.dataSource = ArticleTableViewDataSource(cellIdentifier: "ArticleTableViewCell", items: self.homeViewModel.articleData, configureCell: { (cell, article) in
            print("Arctile ->",article)
            cell.delegate = self
            cell.configure(item: article)
        })
        DispatchQueue.main.async {
            self.articlesTableView.dataSource = self.dataSource
            self.articlesTableView.reloadData()
        }
    }
}


// MARK: - ArticleDelegate
extension HomeViewController: ArticleDelegate{
    func readMoreButton(from cell: ArticleTableViewCell) {
        guard let indexPath = articlesTableView.indexPath(for: cell) else {
            os_log("Failed to get index path for cell containing button", log: OSLog.default, type: .error)
            return
        }
        guard let url = URL(string: self.homeViewModel.articleData[indexPath.row].link ?? "") else {
            os_log("Failed to create URL from article link", log: OSLog.default, type: .error)
            return
        }
        UIApplication.shared.open(url)
    }
}
