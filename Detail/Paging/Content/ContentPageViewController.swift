//
//  ContentPageViewController.swift
//  Detail
//
//  Created by joey on 8/27/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class ContentPageViewController: UIPageViewController {

    fileprivate lazy var pages: [UIViewController] = {
        var pages = [UIViewController]()
        contents.forEach({ (content) in
            pages.append(content.viewController)
        })
        return pages
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(turningPage(notification:)), name: .didClick, object: nil)
    }

    @objc func turningPage(notification: NSNotification) {
        if let indexPath = notification.userInfo?["IndexPath"] as? IndexPath {
            let vc = pages[indexPath.row]
            setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }

}

extension ContentPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index > 0 {
            return pages[index - 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index < pages.count - 1 {
            return pages[index + 1]
        }
        return nil
    }

}
