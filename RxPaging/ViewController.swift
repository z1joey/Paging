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
                        
//        index.subscribe(
//            onNext: {
//                print($0)
//            }
//        ).disposed(by: bag)
        
        (segmentedControl.rx.selectedSegmentIndex <-> self.index).disposed(by: bag)
        (child.index <-> self.index).disposed(by: bag)
        
//        index.bind(to: segmentedControl.rx.selectedSegmentIndex)
//             .disposed(by: bag)
    }
    
}

