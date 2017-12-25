//
//  ARSegmentControlDataSource.swift
//  SegmentControlViewDemo
//
//  Created by Ari on 2017/12/17.
//  Copyright © 2017年 Ari. All rights reserved.
//

import UIKit

protocol ARSegmentControlDataSource {
    ///
    func numberOfItems(in segementControlView: ARSegmentControlView) -> Int
    ///
    func segementControlView(_ segementControlView: ARSegmentControlView, titleInIndex index: Int) -> String
    ///
    func segementControlView(_ segementControlView: ARSegmentControlView, viewControllerInIndex index: Int) -> UIViewController
}
