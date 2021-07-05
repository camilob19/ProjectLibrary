//
//  DetailBookTableViewCell.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 2/07/21.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailBookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containInfoView: GeneralView!
    @IBOutlet weak var coverBookImage: UIImageView!
    @IBOutlet weak var nameBookLabel: UILabel!
    @IBOutlet weak var statusBookLabel: UILabel!
    @IBOutlet weak var authorBookLabel: UILabel!
    @IBOutlet weak var dateBookLabel: UILabel!
    @IBOutlet weak var categoryBookLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(book: Book) {

        nameBookLabel.text = book.title
        authorBookLabel.text = book.author
        statusBookLabel.text = book.status
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }    
}
