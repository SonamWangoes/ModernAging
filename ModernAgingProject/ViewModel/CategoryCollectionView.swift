//
//  CategoryCollectionView.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import Foundation
import UIKit


class CategoryCollectionView: UICollectionView{
    var categories:[Category] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }
    
    func configure(categories: [Category]) {
        self.categories = categories
        self.reloadData()
    }
}

extension CategoryCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        cell.category.text = categories[indexPath.row].name
        return cell
    }
}
