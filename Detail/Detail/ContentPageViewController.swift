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
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return pages.last }

        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return pages.first }

        guard pages.count > nextIndex else { return nil }

        return pages[nextIndex]
    }

}
