//
//  SplittableTableViewController.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

open class SplittableTableViewController: UIViewController {

    private enum Const {
        static let cellReuseIdentifier = "SplittableTableViewController.UITableViewCell"
    }

    private let _leftView = UIView(frame: .zero)
    private let _stackView = UIStackView(frame: .zero)
    private lazy var _leftViewAndRightViewWidthConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: _leftView,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: tableView,
                                  attribute: .width,
                                  multiplier: 1 / 2,
                                  constant: 0)
    }()

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

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(_stackView)
        if #available(iOS 11, *) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: _stackView.topAnchor),
            view.safeAreaLayoutGuideIfExists.leftAnchor.constraint(equalTo: _stackView.leftAnchor),
            view.safeAreaLayoutGuideIfExists.rightAnchor.constraint(equalTo: _stackView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor)
        ])
        } else {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: _stackView.topAnchor),
                view.leftAnchor.constraint(equalTo: _stackView.leftAnchor),
                view.rightAnchor.constraint(equalTo: _stackView.rightAnchor),
                view.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor)
            ])
        }

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
        _leftView.isHidden = !isLandscape
        _leftViewAndRightViewWidthConstraint.isActive = isLandscape
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension SplittableTableViewController: UITableViewDataSource {

    private func isLandscapeTopIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row == 0 && isLandscape
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.splittableTableViewController(tableView: tableView, numberOfRowsInSection: section) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = self.dataSource ?? { fatalError("data source not found") }()
        let cell = dataSource.splittableTableViewController(tableView: tableView, cellForRowAt: indexPath)

        if isLandscapeTopIndexPath(indexPath) {
            if _leftView.subviews.count < 1 {
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
                        if (constraint.firstItem as? UIView) == cell.contentView {
                            var builder = ConstraintBuilder(constraint)
                            builder.firstItem = view
                            view.addConstraint(builder.build())
                        } else if (constraint.secondItem as? UIView) == cell.contentView {
                            var builder = ConstraintBuilder(constraint)
                            builder.secondItem = view
                            view.addConstraint(builder.build())
                        } else {
                            subview.addConstraint(constraint)
                        }
                    }
                }

                constraints.forEach { constraint in
                    if constraint.identifier?.contains("UIView-Encapsulated-Layout") == true {
                        return
                    }

                    if (constraint.firstItem as? UIView) == cell.contentView {
                        var builder = ConstraintBuilder(constraint)
                        builder.firstItem = view
                        view.addConstraint(builder.build())
                    } else if (constraint.secondItem as? UIView) == cell.contentView {
                        var builder = ConstraintBuilder(constraint)
                        builder.secondItem = view
                        view.addConstraint(builder.build())
                    } else {
                        view.addConstraint(constraint)
                    }
                }
                dataSource.splittableTableViewControllerWillMoveTopView(view: view, to: _leftView)
            } else {
                cell.removeFromSuperview()
            }
            return tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier) ?? { fatalError("") }()
        } else {
            return cell
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.splittableTableViewControllerNumberOfSections(in: tableView) ?? 1
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource?.splittableTableViewController(tableView: tableView, titleForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource?.splittableTableViewController(tableView: tableView, canEditRowAt: indexPath) ?? false
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return dataSource?.splittableTableViewController(tableView: tableView, canMoveRowAt: indexPath) ?? false
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSource?.splittableTableViewControllerSectionIndexTitles(for: tableView)
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return dataSource?.splittableTableViewController(tableView: tableView, sectionForSectionIndexTitle: title, at: index) ?? index
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataSource?.splittableTableViewController(tableView: tableView, commit: editingStyle, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource?.splittableTableViewController(tableView: tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
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
