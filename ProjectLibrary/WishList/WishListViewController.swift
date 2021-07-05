//
//  WishListViewController.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 1/07/21.
//

import UIKit

class WishListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: WishListViewModel = WishListViewModel(loader: BookLoader(),
                                                         coreDataManager: CoreDataManager())
    
    let nibDetailBook = String(describing: DetailBookTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        viewModel.didUpdateModels = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    fileprivate func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: nibDetailBook, bundle: nil),
                           forCellReuseIdentifier: nibDetailBook)
        tableView.rowHeight = 160
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getBooksInformation()
    }
}

extension WishListViewController: UITableViewDelegate {
    
}

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibDetailBook, for: indexPath) as? DetailBookTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.config(book: viewModel.models[indexPath.row])
        return cell
    }   
}
