//
//  Content.swift
//  Detail
//
//  Created by joey on 8/27/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

struct Content {
    let title: String
    let viewController: UIViewController
}

let contents: [Content] = {
    var contents = [Content]()

    let redViewController = UIViewController()
    redViewController.view.backgroundColor = .red
    contents.append(Content(title: "RedView", viewController: redViewController))

    let yellowViewController = UIViewController()
    yellowViewController.view.backgroundColor = .yellow
    contents.append(Content(title: "YellowView", viewController: yellowViewController))

    let blackViewController = UIViewController()
    blackViewController.view.backgroundColor = .black
    contents.append(Content(title: "BlackView", viewController: blackViewController))

    let blueViewController = UIViewController()
    blueViewController.view.backgroundColor = .blue
    contents.append(Content(title: "BlueView", viewController: blueViewController))

    let cyanViewController = UIViewController()
    cyanViewController.view.backgroundColor = .cyan
    contents.append(Content(title: "CyanView", viewController: cyanViewController))

    return contents
}()
