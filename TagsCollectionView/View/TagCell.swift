//
//  TagCell.swift
//  TagsCollectionView
//
//  Created by Alex Stratu on 05/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(tag: String) {
        tagLabel.text = tag
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = bounds.height/2
    }
}
