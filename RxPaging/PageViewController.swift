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
        setupRxGestures()
    }

    func setPage(index: (old: Int, new: Int)) {
        let page = pages[index.new]
        if index.new > index.old {
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([page], direction: .reverse, animated: true, completion: nil)
        }
    }

}

fileprivate extension PageViewController {

    func setupRxGestures() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        Observable.of(swipeLeft.rx.event, swipeRight.rx.event)
            .merge()
            .subscribe(onNext: {
                var new = 0
                let old = self.index.value
                if $0.direction == .left {
                    new = (old + 1) > (self.pages.count - 1) ? (self.pages.count - 1) : (old + 1)
                }
                if $0.direction == .right {
                    new = (old - 1) < 0 ? 0 : (old - 1)
                }
                self.index.accept(new)
            })
            .disposed(by: bag)
    }

}
