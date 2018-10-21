//
//  ConstraintBuilder.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

struct ConstraintBuilder {
    var firstItem: AnyObject?
    var firstAttribute: NSLayoutConstraint.Attribute
    var secondItem: AnyObject?
    var secondAttribute: NSLayoutConstraint.Attribute
    var relation: NSLayoutConstraint.Relation
    var multiplier: CGFloat
    var constant: CGFloat
    var priority: UILayoutPriority
    var shouldBeArchived: Bool
    var isActive: Bool
    var identifier: String?
}

extension ConstraintBuilder {
    init(_ constraint: NSLayoutConstraint) {
        self.firstItem = constraint.firstItem
        self.firstAttribute = constraint.firstAttribute
        self.relation = constraint.relation
        self.secondItem = constraint.secondItem
        self.secondAttribute = constraint.secondAttribute
        self.multiplier = constraint.multiplier
        self.constant = constraint.constant
        self.priority = constraint.priority
        self.shouldBeArchived = constraint.shouldBeArchived
        self.isActive = constraint.isActive
        self.identifier = constraint.identifier
    }

    func build() -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: firstItem as Any,
                                            attribute: firstAttribute,
                                            relatedBy: relation,
                                            toItem: secondItem,
                                            attribute: secondAttribute,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.priority = priority
        constraint.shouldBeArchived = shouldBeArchived
        constraint.isActive = isActive
        constraint.identifier = identifier
        return constraint
    }
}
