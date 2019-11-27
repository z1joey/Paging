//
//  ViewController.swift
//  RxPaging
//
//  Created by Yi Zhang on 2019/11/26.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var index = BehaviorRelay<Int>(value: 0)
    
    let bag = DisposeBag()
    
    var child: PageViewController {
        var vc = PageViewController()
        if let child = self.children.first as? PageViewController {
            vc = child
        }
        return vc
    }
    
    var pages: [UIViewController] {
        return child.pages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        (segmentedControl.rx.selectedSegmentIndex <-> index).disposed(by: bag)
        //(child.index <-> self.index).disposed(by: bag)

        Observable.of(self.index, child.index)
            .merge()
            .map { (old: 0, new: $0) }
            .scan((old: 0, new: 0)) { previous, current in
                return (old: previous.new, new: current.new)
            }
            .subscribe(
                onNext: {
                    print($0)
                    self.segmentedControl.selectedSegmentIndex = $0.new
                    self.child.setPage(index: $0)
                },
                onCompleted: {
                    print("Completed")
                },
                onDisposed: {
                    print("Disposed")
                }
            )
            .disposed(by: bag)
    }
    
}

