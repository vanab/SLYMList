//
//  CategoryTableViewCell.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, CategoryCellView {
    @IBOutlet var levelSpace: NSLayoutConstraint!
    @IBOutlet var categoryTitleLabel: UILabel!

    //MARK: - CategoryCellView
    func display(title: String) {
        categoryTitleLabel.text = title
    }
    
    func display(level: Int) {
        let leftSpace: CGFloat = CGFloat(25*level)
        levelSpace.constant = leftSpace
        separatorInset = UIEdgeInsetsMake(0, leftSpace, 0, 0)
    }
}
