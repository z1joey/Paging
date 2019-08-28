//
//  ViewController.swift
//  Detail
//
//  Created by joey on 8/27/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggle(notification:)), name: .toogleMenu, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    @objc func toggle(notification: Notification) {
        if let indexPath = notification.userInfo?["IndexPath"] as? IndexPath, indexPath.row < contents.count {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

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
            NotificationCenter.default.post(name: .turnPage, object: nil, userInfo: ["IndexPath": indexPath])
        }
    }

}


