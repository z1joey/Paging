//
//  PageViewController.swift
//  RxPaging
//
//  Created by Yi Zhang on 2019/11/26.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PageViewController: UIPageViewController {
    
    lazy var pages: [UIViewController] = {
        let red = UIViewController()
        red.view.backgroundColor = .red
        
        let yellow = UIViewController()
        yellow.view.backgroundColor = .yellow
        
        return [red, yellow]
    }()
    
    var index = BehaviorRelay<Int>(value: 0)
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRxPaging()
        setupGestures()
    }

}

fileprivate extension PageViewController {

    func setupRxPaging() {
        index
            .map { (old: 0, new: $0) }
            .scan((old: 0, new: 0)) { previous, current in
                return (old: previous.new, new: current.new)
            }
            .subscribe(
                onNext: {
                    self.setPage(index: $0)
                }
            )
            .disposed(by: bag)
    }

    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }

    func setPage(index: (old: Int, new: Int)) {
        let page = pages[index.new]
        if index.new > index.old {
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([page], direction: .reverse, animated: true, completion: nil)
        }
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        var new = 0
        if gesture.direction == .left {
            new = (index.value + 1) > (pages.count - 1) ? (pages.count - 1) : (index.value + 1)
        } else if gesture.direction == .right {
            new = (index.value - 1) < 0 ? 0 : (index.value - 1)
        }
        index.accept(new)
    }

}
