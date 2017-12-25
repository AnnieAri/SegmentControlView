//
//  ARSegmentControlContentsView.swift
//  SegmentControlViewDemo
//
//  Created by Ari on 2017/12/17.
//  Copyright © 2017年 Ari. All rights reserved.
//

import UIKit

class ARSegmentControlContentsView: UIScrollView {
    var lastViewControllers = [UIViewController]() {
        didSet {
            retsetController()
        }
    }
    convenience init(frame: CGRect, config: ARSegmentControlConfig) {
        self.init(frame: frame)
        isPagingEnabled = config.isPageEnable
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        
    }
    func retsetController(){
        lastViewControllers.forEach({ (vc) in
            vc.view.removeFromSuperview()
        })
        let width = bounds.size.width
        let height = bounds.size.height
        for i in 0 ..< lastViewControllers.count {
            ///控制器
            let vc = lastViewControllers[i]
                vc.view.frame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height)
            addSubview(vc.view)
        }
    }
    
}
