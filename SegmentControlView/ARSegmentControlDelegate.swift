//
//  ARSegmentControlDelegate.swift
//  SegmentControlViewDemo
//
//  Created by Ari on 2017/12/17.
//  Copyright © 2017年 Ari. All rights reserved.
//

import UIKit

@objc protocol ARSegmentControlDelegate {
    @objc optional func segementControlView(_ segementControlView: ARSegmentControlView, willShowIndex index: Int)
    @objc optional func segementControlView(_ segementControlView: ARSegmentControlView, didShowIndex index: Int)
}
