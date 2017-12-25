//
//  ARSegmentControlView.swift
//  SegmentControlViewDemo
//
//  Created by Ari on 2017/12/17.
//  Copyright © 2017年 Ari. All rights reserved.
//

import UIKit

let _screenWidth = UIScreen.main.bounds.size.width
let _screenHeight = UIScreen.main.bounds.size.height

class ARSegmentControlConfig {
    // MARK: - 标题配置
    ///标题View总大小
    var titleViewFrame = CGRect(x: 0, y: 0, width: _screenWidth, height: 44)
    ///选中的标题颜色
    var selectedLabelColor = UIColor.red
    ///未选中的标题颜色
    var unSelectedLabelColor = UIColor.black
    ///titleview背景颜色
    ///标题高度
    var titleLabelHeight: CGFloat = 30.0
    ///标题宽度
    var titleLabelWidth: CGFloat = 60.0
    ///标题间距
    var titleLabelMargin: CGFloat = 8.0
    ///标题选中标识 颜色
    var titleIndicatorColor = UIColor.blue
    // MARK: - 控制器配置
    ///控制器是否分页
    var isPageEnable = true
}

class ARSegmentControlView: UIView {

    fileprivate var config: ARSegmentControlConfig!
    fileprivate (set) var consultValue: ARValue!
    open var dataSource: ARSegmentControlDataSource?{
        didSet{
            reloadData()
        }
    }
    open var delegate: ARSegmentControlDelegate?
    ///之前的viewControll
//    fileprivate (set) var lastViewControllers: [UIViewController]?
    ///titleView
    fileprivate (set) var titleView: ARSegmentControlTitleView!
    ///contentsView
    fileprivate var contensView: ARSegmentControlContentsView!
    convenience init(frame: CGRect, config: ARSegmentControlConfig = ARSegmentControlConfig()) {
        self.init(frame: frame)
        self.config = config
        consultValue = ARValue(0, bounds.size.width)
        setupUI()
        bindingAction()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        titleView = ARSegmentControlTitleView(config: config)
        contensView = ARSegmentControlContentsView(frame: self.bounds,config: config)
        contensView.delegate = self
        addSubview(contensView)
    }
    private func bindingAction() {
        titleView.selectIndexBlock = { [weak self] index in
            guard let view = self else {return}
            view.delegate?.segementControlView?(view, willShowIndex: index)
            view.contensView.scrollRectToVisible(CGRect(x: CGFloat(index) * view.bounds.size.width, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), animated: true)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contensView.frame = self.bounds
    }
    ///refresh UI
    open func reloadData(){
        print("reloadData")
        
        var vcs = [UIViewController]()
       
        let itemsCount = (dataSource?.numberOfItems(in: self) ?? 0)
        var titles = [String]()
        for i in 0 ..< itemsCount{
            vcs.append(dataSource!.segementControlView(self, viewControllerInIndex: i))
            titles.append(dataSource!.segementControlView(self, titleInIndex: i))
        }
        titleView.titles = titles
        contensView.lastViewControllers = vcs
        titleView.contentSize = CGSize(width: (config.titleLabelMargin + config.titleLabelWidth) * CGFloat(itemsCount) + config.titleLabelMargin, height: config.titleViewFrame.size.height)
        contensView.contentSize = CGSize(width: bounds.size.width * CGFloat(itemsCount), height: bounds.size.height)
    }
    fileprivate func resetChildView(){
        
    }
    func updateConfig(_ configBlock:(ARSegmentControlConfig)->()){
        configBlock(config)
        titleView.resetUI()
        contensView.isPagingEnabled = config.isPageEnable
    }

}
extension ARSegmentControlView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        titleView.scrollIndicator(withConsultValue: consultValue, controllerOffSet: scrollView.contentOffset.x)
    }
    ///该方法会在 scrollView调用方法滚动停止时调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.segementControlView?(self, didShowIndex: Int(scrollView.contentOffset.x/bounds.size.width))
    }
    ///该方法会在 scrollView手势滚动停止时调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.segementControlView?(self, didShowIndex: Int(scrollView.contentOffset.x/bounds.size.width))
        titleView.setSelectedIndex(Int(scrollView.contentOffset.x/bounds.size.width))
    }
}
