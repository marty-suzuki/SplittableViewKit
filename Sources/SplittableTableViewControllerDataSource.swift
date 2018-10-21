//
//  SplittableTableViewControllerDataSource.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

public protocol SplittableTableViewControllerDataSource: SplittableDataSource {
    func splittable(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func splittable(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func splittableNumberOfSections(in tableView: UITableView) -> Int
    func splittable(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    func splittable(tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    func splittable(tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    func splittableSectionIndexTitles(for tableView: UITableView) -> [String]?
    func splittable(tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    func splittable(tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    func splittable(tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

extension SplittableTableViewControllerDataSource {
    public func splittableNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func splittable(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    public func splittable(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }

    public func splittable(tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func splittable(tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func splittableSectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }

    public func splittable(tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    public func splittable(tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}

    public func splittable(tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
}
