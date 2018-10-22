//
//  SplittableDataSource.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

public protocol SplittableDataSource: AnyObject {
    func splittableViewForLeftView(topView: UIView, isLandscape: Bool) -> UIView
}
