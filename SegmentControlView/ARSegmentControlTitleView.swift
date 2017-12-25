//
//  ARSegmentControlTitleView.swift
//  SegmentControlViewDemo
//
//  Created by Ari on 2017/12/17.
//  Copyright © 2017年 Ari. All rights reserved.
//

import UIKit

class ARSegmentControlTitleView: UIScrollView {
    
    ///点击某个label 参数返回点击的index
    var selectIndexBlock: ((Int)->())?
    
    fileprivate var indicatorView: UIView!
    fileprivate var labels = [UILabel]()
    fileprivate (set) var resultValue: ARValue!
    var titles: [String]! {
        didSet {
            resetUI()
        }
    }
    fileprivate (set) var config: ARSegmentControlConfig!
    convenience init(config: ARSegmentControlConfig) {
        self.init(frame: config.titleViewFrame)
        self.config = config
        setupUI()
    }
    fileprivate (set) var selectedIndex: Int = 0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        indicatorView = UIView()
        indicatorView.backgroundColor = config.titleIndicatorColor
        addSubview(indicatorView)
    }
    func resetUI(){
        labels.forEach { (l) in
            l.removeFromSuperview()
        }
        labels.removeAll()
        
        let labelWidth = config.titleLabelWidth
        for i in 0 ..< titles.count {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.ar_setTapGes(target: self, action: #selector(labelTap(_:)))
            label.textAlignment = .center
            label.text = titles[i]
            label.textColor = config.unSelectedLabelColor
            label.frame = CGRect(x: config.titleLabelMargin + CGFloat(i)*(labelWidth + config.titleLabelMargin), y: (config.titleViewFrame.size.height - config.titleLabelHeight)/2, width: labelWidth, height: config.titleLabelHeight)
            label.tag = i
            addSubview(label)
            labels.append(label)
        }
        resultValue = ARValue(config.titleLabelMargin + config.titleLabelWidth/2, 2*config.titleLabelMargin + 3 *  config.titleLabelWidth/2)
        if titles.count>0 {
            indicatorView.frame = CGRect(x: 0, y: bounds.size.height - 4, width: config.titleLabelWidth, height: 4)
            indicatorView.center.x = labels[0].center.x
            indicatorView.backgroundColor = config.titleIndicatorColor
            indicatorView.isHidden = false
        }else{
            indicatorView.isHidden = true
        }
        
    }
    @objc fileprivate func labelTap(_ sender: UITapGestureRecognizer){
        selectIndexBlock?(sender.view!.tag)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    ///滚动指示器
    func scrollIndicator(withConsultValue consultValue: ARValue, controllerOffSet: CGFloat){
        indicatorView.center.x = ar_result(with: controllerOffSet, resultValue: resultValue, consultValue: consultValue)
    }
    ///确定选择的索引
    func setSelectedIndex(_ index: Int){
//        ARLog("选中\(index)")
        selectedIndex = index
    }
    
}
