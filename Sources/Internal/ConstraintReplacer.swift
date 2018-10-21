//
//  ConstraintReplacer.swift
//  SplittableViewKit
//
//  Created by 鈴木 大貴 on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

enum ConstraintReplacer {
    static func replacedIfNeeded(_ constraint: NSLayoutConstraint,
                                 from fromView: UIView,
                                 to toView: UIView) -> NSLayoutConstraint? {
        if (constraint.firstItem as? UIView) == fromView {
            var builder = ConstraintBuilder(constraint)
            builder.firstItem = toView
            return builder.build()
        } else if (constraint.secondItem as? UIView) == fromView {
            var builder = ConstraintBuilder(constraint)
            builder.secondItem = toView
            return builder.build()
        } else {
            return nil
        }
    }
}
