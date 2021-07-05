//
//  BookDetailViewController.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 30/06/21.
//

import UIKit
import SVProgressHUD

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundInfoBookView: GeneralView!
    @IBOutlet weak var wishListButton: GeneralButton!
    @IBOutlet weak var rentButton: GeneralButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundCommentView: GeneralView!
    @IBOutlet weak var informationView: UIView!
    
    let nibComment = String(describing: CommentTableViewCell.self)
    let nibDetailBook = String(describing: DetailBookTableViewCell.self)
    
    var detailView: DetailBookView = DetailBookView()
    var book: Book?
    let manager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        rentButton.backgroundColor = Constants.Colors.blueColor
        configTableView()
        if let resultBook = book {detailView.config(book: resultBook)}
        detailView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
        SVProgressHUD.dismiss()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: nibComment, bundle: nil),
                           forCellReuseIdentifier: nibComment)
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
        
        detailView.frame = informationView.bounds
        informationView.addSubview(detailView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint(item: detailView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: informationView,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: detailView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: informationView,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: detailView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: informationView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: detailView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: informationView,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func wishListButton(_ sender: Any) {
        guard let id = book?.id else { return }
        if manager.saveFavorite(id: id) {
            showMessage("Added to wish list successfully")
        }
    }
    
    @IBAction func rentButton(_ sender: Any) {
        guard let id = book?.id else { return }
        if manager.saveRentals(id: id) {
            showMessage("Added to rentals successfully")
        }
    }
    
    private func showMessage(_ msg: String) {
        
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
}

extension BookDetailViewController: UITableViewDelegate {
    
}

extension BookDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibComment,
                                                       for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}
