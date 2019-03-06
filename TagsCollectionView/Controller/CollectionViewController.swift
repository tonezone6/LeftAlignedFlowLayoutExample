//
//  CollectionViewController.swift
//  TagsCollectionView
//
//  Created by Alex Stratu on 05/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var tags: [String] = [
        "🍇 Grapes", "🍈 Melon", "🍉 Watermelon", "🍊 Tangerine", "🍋 Lemon",
        "🍌 Banana", "🍍 Pineapple", "🥭 Mango", "🍎 Red Apple", "🍏 Green Apple",
        "🍐 Pear", "🍑 Peach", "🍒 Cherries", "🍓 Strawberry", "🥝 Kiwi Fruit"
    ]
    
    @IBOutlet weak var collectionView: SelfsizingCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flow = LeftAlignedFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.minimumInteritemSpacing = 6.0
        flow.minimumLineSpacing = 6.0
        flow.estimatedItemSize = CGSize(width: 116, height: 37)
        collectionView.setCollectionViewLayout(flow, animated: false, completion: nil)
        collectionView.register(cellType: TagCell.self)
    }
    
    public func add(tag: String) {
        tags.append(tag)
        collectionView.reloadData()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(type: TagCell.self, for: indexPath) {
            cell.setCell(tag: tags[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

class SelfsizingCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}
