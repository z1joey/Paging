//
//  MenuController.swift
//  Detail
//
//  Created by joey on 8/27/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class MenuController: NSObject {
    // fileprivate let titles = ["title1", "title2", "title3"]
}

extension MenuController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell
        cell?.titleLabel.text = contents[indexPath.row].title
        cell?.isSelected = false
        return cell ?? MenuCollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell {
            cell.isSelected = cell.isSelected ? false : true
            //NotificationCenter.default.post(name: .didClick, object: self)
            NotificationCenter.default.post(name: .didClick, object: nil, userInfo: ["IndexPath": indexPath])
        }
    }

}

extension Notification.Name {
    static let didClick = Notification.Name("didClickMenu")
}
