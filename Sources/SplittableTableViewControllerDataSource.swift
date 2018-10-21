//
//  SplittableTableViewControllerDataSource.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

public protocol SplittableTableViewControllerDataSource: AnyObject {
    func splittableTableViewController(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func splittableTableViewController(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func splittableTableViewControllerWillMoveTopView(view: UIView, to leftView: UIView)
    func splittableTableViewControllerNumberOfSections(in tableView: UITableView) -> Int
    func splittableTableViewController(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    func splittableTableViewController(tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewController(tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewControllerSectionIndexTitles(for tableView: UITableView) -> [String]?
    func splittableTableViewController(tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    func splittableTableViewController(tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

extension SplittableTableViewControllerDataSource {
    public func splittableTableViewControllerNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func splittableTableViewController(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    public func splittableTableViewController(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }

    public func splittableTableViewController(tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func splittableTableViewController(tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func splittableTableViewControllerSectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }

    public func splittableTableViewController(tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    public func splittableTableViewController(tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}

    public func splittableTableViewController(tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
}
