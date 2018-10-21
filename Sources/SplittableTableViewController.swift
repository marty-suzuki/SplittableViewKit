//
//  SplittableTableViewController.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

open class SplittableTableViewController: UIViewController {

    private let _leftView = UIView(frame: .zero)
    private let _stackView = UIStackView(frame: .zero)
    private lazy var _leftViewAndRightViewWidthConstraint = makeLeftViewAndRightViewWidthConstraint()

    private var topView: UIView?

    public weak var dataSource: SplittableTableViewControllerDataSource?
    public weak var delegate: SplittableTableViewControllerDelegate?

    public let tableView = UITableView(frame: .zero)
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

    public var ratio: Ratio

    public init(ratio: Ratio = .default) {
        self.ratio = ratio
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        self.ratio = .default
        super.init(coder: aDecoder)
    }

    private func makeLeftViewAndRightViewWidthConstraint() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: _leftView,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: tableView,
                                  attribute: .width,
                                  multiplier: ratio.left / ratio.right,
                                  constant: 0)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(_stackView)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: _stackView.topAnchor),
            view.safeAreaLayoutGuideIfExists.leftAnchor.constraint(equalTo: _stackView.leftAnchor),
            view.safeAreaLayoutGuideIfExists.rightAnchor.constraint(equalTo: _stackView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor)
        ])

        _leftView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.addArrangedSubview(_leftView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.addArrangedSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Const.cellReuseIdentifier)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if tableView.numberOfRows(inSection: 0) > 0 {
            _leftView.subviews.forEach { $0.removeFromSuperview() }
            tableView.reloadData()
        }
        if !isLandscape {
            topView?.removeFromSuperview()
            topView = nil
        }
        _leftView.isHidden = !isLandscape

        _leftViewAndRightViewWidthConstraint.isActive = false
        _leftViewAndRightViewWidthConstraint = makeLeftViewAndRightViewWidthConstraint()
        _leftViewAndRightViewWidthConstraint.isActive = isLandscape

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

extension SplittableTableViewController: UITableViewDataSource {

    private func isLandscapeTopIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row == 0 && isLandscape
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.splittable(tableView: tableView, numberOfRowsInSection: section) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = self.dataSource ?? { fatalError("data source not found") }()
        let cell = dataSource.splittable(tableView: tableView, cellForRowAt: indexPath)

        if isLandscapeTopIndexPath(indexPath) {
            if topView == nil {
                let topView = makeTopView(with: cell)
                let view = dataSource.splittableViewForLeftView(topView: topView)
                _leftView.addSubview(view)
                view.frame = _leftView.bounds
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.topView = topView
            }
            cell.removeFromSuperview()
            return tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier) ?? { fatalError("") }()
        } else {
            return cell
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.splittableNumberOfSections(in: tableView) ?? 1
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource?.splittable(tableView: tableView, titleForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource?.splittable(tableView: tableView, canEditRowAt: indexPath) ?? false
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return dataSource?.splittable(tableView: tableView, canMoveRowAt: indexPath) ?? false
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSource?.splittableSectionIndexTitles(for: tableView)
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return dataSource?.splittable(tableView: tableView, sectionForSectionIndexTitle: title, at: index) ?? index
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataSource?.splittable(tableView: tableView, commit: editingStyle, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource?.splittable(tableView: tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
}

#if swift(>=4.2)
let UITableViewAutomaticDimension = UITableView.automaticDimension
#endif

extension SplittableTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLandscapeTopIndexPath(indexPath) {
            return CGFloat.leastNonzeroMagnitude
        } else {
            return delegate?.splittableTableViewController(tableView: tableView, heightForRowAt: indexPath)
                ?? UITableViewAutomaticDimension
        }
    }
}

extension SplittableTableViewController {
    private enum Const {
        static let cellReuseIdentifier = "SplittableTableViewController.UITableViewCell"
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
