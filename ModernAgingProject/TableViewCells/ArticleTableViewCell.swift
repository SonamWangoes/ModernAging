//
//  ArticleTableViewCell.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import UIKit

protocol ArticleDelegate: AnyObject {
    func readMoreButton(from cell: ArticleTableViewCell)
}

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var collectionView: CategoryCollectionView!
    @IBOutlet weak var btnLike: UIButton!
    
    weak var delegate: ArticleDelegate?
    var isLiked:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item:ArticlesData) {
        headline.text = item.headline
        collectionView.configure(categories: item.categories ?? [])
    }
    
    @IBAction func readMore(_ sender: UIButton) {
        delegate?.readMoreButton(from: self)
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        isLiked = !isLiked
        if isLiked {
            if let image = UIImage(named: "unlike") {
                btnLike.setImage(image, for: .normal)}
        }else {
            if let image = UIImage(named: "like") {
                btnLike.setImage(image, for: .normal)}
        }
    }
}
