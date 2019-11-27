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
        setupRxGestures()
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

    func setPage(index: (old: Int, new: Int)) {
        let page = pages[index.new]
        if index.new > index.old {
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([page], direction: .reverse, animated: true, completion: nil)
        }
    }

//    func handleGesture(gesture: UISwipeGestureRecognizer) {
//        var new = 0
//        if gesture.direction == .left {
//            new = (index.value + 1) > (pages.count - 1) ? (pages.count - 1) : (index.value + 1)
//        } else if gesture.direction == .right {
//            new = (index.value - 1) < 0 ? 0 : (index.value - 1)
//        }
//        index.accept(new)
//    }

}
