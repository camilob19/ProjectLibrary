//
//  DetailBookView.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailBookView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var coverBookImage: UIImageView!
    @IBOutlet weak var nameBookLabel: UILabel!
    @IBOutlet weak var statusBookLabel: UILabel!
    @IBOutlet weak var authorBookLabel: UILabel!
    @IBOutlet weak var dateBookLabel: UILabel!
    @IBOutlet weak var categoryBookLabel: UILabel!
    
    func config(book: Book) {
        nameBookLabel.text = book.title
        statusBookLabel.text = book.status
        authorBookLabel.text = book.author
        dateBookLabel.text = book.year
        categoryBookLabel.text = book.genre
        
        let downloader = ImageDownloader()
        guard let url = URL(string: book.image) else {
            coverBookImage.image = #imageLiteral(resourceName: "noImageAvalible")
            return
        }
        let urlRequest = URLRequest(url: url)

        downloader.download(urlRequest, completion: { response in
            if case .success(let image) = response.result {
                self.coverBookImage.image = image
            }
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DetailBookView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
}
