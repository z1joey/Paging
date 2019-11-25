//
//  MenuCollectionViewCell.swift
//  Detail
//
//  Created by joey on 8/27/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorLine: UIView!

    override var isSelected: Bool {
        didSet {
            layoutSubviews()
        }
    }

    override func layoutSubviews() {
        if isSelected {
            indicatorLine.isHidden = false
        } else {
            indicatorLine.isHidden = true
        }
    }

}
