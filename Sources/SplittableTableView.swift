//
//  SplittableTableView.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

public final class SplittableTableView: UIView {

    private let _tableView: UITableView
    private let _leftView = UIView(frame: .zero)
    private let _stackView = UIStackView(frame: .zero)
    private lazy var _leftViewAndRightViewWidthConstraint = makeLeftViewAndRightViewWidthConstraint()
    private lazy var _topViewAndBottomViewHeightConstraint = makeTopViewAndBottomViewHeightConstraint()

    private var topView: UIView?

    public var dataSource: SplittableTableViewDataSource? {
        set {
            _dataSourceProxy.dataSource = newValue
        }
        get {
            return _dataSourceProxy.dataSource
        }
    }
    private lazy var _dataSourceProxy = SplittableTableViewDataSourceProxy(proxy: self)

    public var delegate: SplittableTableViewDelegate? {
        set {
            _delegateProxy.delegate = newValue
        }
        get {
            return _delegateProxy.delegate
        }
    }
    private lazy var _delegateProxy = SplittableTableViewDelegateProxy(proxy: self)


    /// - note: Do not set `dataSource` and `delegate` directly.
    ///         Please use `SplittableTableView.dataSource` or `SplittableTableView.delegate`
    public var rightView: UITableView {
        return _tableView
    }

    public var leftView: UIView? {
        if isLandscape {
            return _leftView
        } else {
            return nil
        }
    }

    public var isLandscape: Bool {
        return traitCollection.verticalSizeClass == .compact
    }

    public var isFixedTop: Bool {
        didSet {
            if isLandscape {
                return
            }
            updateLayout()
        }
    }

    public var ratio: Ratio

    public init(frame: CGRect,
                style: UITableView.Style = .plain,
                isFixedTop: Bool = false,
                ratio: Ratio = .default) {
        self.ratio = ratio
        self.isFixedTop = isFixedTop
        self._tableView = UITableView(frame: frame, style: style)
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        self.ratio = .default
        self.isFixedTop = false
        self._tableView = UITableView(frame: .zero, style: .plain)
        super.init(coder: aDecoder)
        setupViews()
    }

    private func makeLeftViewAndRightViewWidthConstraint() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: _leftView,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: _tableView,
                                  attribute: .width,
                                  multiplier: ratio.left / ratio.right,
                                  constant: 0)
    }

    private func makeTopViewAndBottomViewHeightConstraint() -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: _leftView,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: _tableView,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: 0)
        constraint.priority = .defaultLow
        return constraint
    }

    private func setupViews() {
        backgroundColor = .white

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(_stackView)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: _stackView.topAnchor),
            safeAreaLayoutGuideIfExists.leftAnchor.constraint(equalTo: _stackView.leftAnchor),
            safeAreaLayoutGuideIfExists.rightAnchor.constraint(equalTo: _stackView.rightAnchor),
            bottomAnchor.constraint(equalTo: _stackView.bottomAnchor)
        ])

        _leftView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.addArrangedSubview(_leftView)
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.addArrangedSubview(_tableView)

        _tableView.dataSource = _dataSourceProxy
        _tableView.delegate = _delegateProxy
        _tableView.register(UITableViewCell.self,
                            forCellReuseIdentifier: Const.cellReuseIdentifier)

        _topViewAndBottomViewHeightConstraint.isActive = isFixedTop && !isLandscape
    }

    private func updateLayout() {
        if _tableView.numberOfRows(inSection: 0) > 0 {
            _leftView.subviews.forEach { $0.removeFromSuperview() }
            _tableView.reloadData()
        }

        _leftView.isHidden = !(isLandscape || isFixedTop)

        _stackView.axis = isLandscape ? .horizontal : .vertical
        _leftViewAndRightViewWidthConstraint.isActive = false
        _leftViewAndRightViewWidthConstraint = makeLeftViewAndRightViewWidthConstraint()
        _leftViewAndRightViewWidthConstraint.isActive = isLandscape

        _topViewAndBottomViewHeightConstraint.isActive = isFixedTop && !isLandscape
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateLayout()
        super.traitCollectionDidChange(previousTraitCollection)
    }

    private func makeTopView(with cell: UITableViewCell) -> UIView {
        let contentViews: [(UIView, [NSLayoutConstraint])] = cell.contentView
            .subviews
            .reduce([(UIView, [NSLayoutConstraint])]()) { result, view in
                result + [(view, view.constraints)]
        }
        let constraints = cell.contentView.constraints

        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentViews.forEach { values in
            let (subview, constraints) = values
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            constraints.forEach { constraint in
                if let constraint = ConstraintReplacer
                    .replacedIfNeeded(constraint,
                                      from: cell.contentView,
                                      to: view) {
                    view.addConstraint(constraint)
                } else {
                    subview.addConstraint(constraint)
                }
            }
        }

        constraints.forEach { constraint in
            if constraint.identifier?.contains("UIView-Encapsulated-Layout") == true {
                return
            }

            if let constraint = ConstraintReplacer
                .replacedIfNeeded(constraint,
                                  from: cell.contentView,
                                  to: view) {
                view.addConstraint(constraint)
            } else {
                view.addConstraint(constraint)
            }
        }

        return view
    }
}

extension SplittableTableView: _SplittableTableViewDataSource {
    private func isLandscapeTopIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row == 0 && isLandscape
    }

    private func shouldHandleFixedTop(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row == 0 && isFixedTop
    }

    func proxy(tableView: UITableView, cellForRowAt indexPath: IndexPath, cell: UITableViewCell) -> UITableViewCell {
        if isLandscapeTopIndexPath(indexPath) || shouldHandleFixedTop(indexPath) {
            topView?.removeFromSuperview()
            topView = {
                let topView = makeTopView(with: cell)
                let layoutType: LayoutType = isLandscape ? .left : .fixedTop
                let view = dataSource?.splittableContainerViewFor(topView: topView, layoutType: layoutType) ?? Undefined.object()
                view.translatesAutoresizingMaskIntoConstraints = false
                _leftView.addSubview(view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: _leftView.topAnchor, constant: 0),
                    view.leftAnchor.constraint(equalTo: _leftView.leftAnchor, constant: 0),
                    view.rightAnchor.constraint(equalTo: _leftView.rightAnchor, constant: 0),
                    view.bottomAnchor.constraint(equalTo: _leftView.bottomAnchor, constant: 0)
                ])
                return topView
            }()
            cell.removeFromSuperview()
            return tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier) ?? Undefined.object()
        } else {
            return cell
        }
    }
}

extension SplittableTableView: _SplittableTableViewDelegate {
    func proxy(tableView: UITableView, heightForRowAt indexPath: IndexPath, height: CGFloat) -> CGFloat {
        if isLandscapeTopIndexPath(indexPath) || shouldHandleFixedTop(indexPath) {
            return CGFloat.leastNonzeroMagnitude
        } else {
            return height
        }
    }
}

extension SplittableTableView {
    private enum Const {
        static let cellReuseIdentifier = "SplittableTableView.UITableViewCell"
    }

    public struct Ratio {
        public static let `default` = Ratio(left: 1, right: 2)

        public let left: CGFloat
        public let right: CGFloat

        public init(left: CGFloat, right: CGFloat) {
            self.left = left
            self.right = right
        }
    }
}
