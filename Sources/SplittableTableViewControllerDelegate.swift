//
//  SplittableTableViewControllerDelegate.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

public protocol SplittableTableViewControllerDelegate: AnyObject {
    func splittableTableViewController(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    func splittableTableViewController(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    func splittableTableViewController(tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    func splittableTableViewController(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    func splittableTableViewController(tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func splittableTableViewController(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func splittableTableViewController(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    func splittableTableViewController(tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    func splittableTableViewController(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    func splittableTableViewController(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    func splittableTableViewController(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func splittableTableViewController(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    func splittableTableViewController(tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewController(tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    func splittableTableViewController(tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    func splittableTableViewController(tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    func splittableTableViewController(tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    func splittableTableViewController(tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    func splittableTableViewController(tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    func splittableTableViewController(tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    func splittableTableViewController(tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewController(tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    func splittableTableViewController(tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    func splittableTableViewController(tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    func splittableTableViewController(tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    func splittableTableViewController(tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewController(tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    func splittableTableViewController(tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    func splittableTableViewController(tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    func splittableTableViewController(tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    func splittableTableViewController(tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    func splittableTableViewControllerIndexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
    func splittableTableViewController(tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
}

extension SplittableTableViewControllerDelegate {
    public func splittableTableViewController(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {}
    public func splittableTableViewController(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {}
    public func splittableTableViewController(tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {}
    public func splittableTableViewController(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {}
    public func splittableTableViewController(tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    public func splittableTableViewController(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    public func splittableTableViewController(tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {}
    public func splittableTableViewController(tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {}
    public func splittableTableViewController(tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return sourceIndexPath
    }
    public func splittableTableViewController(tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 0
    }
    public func splittableTableViewController(tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {}
    public func splittableTableViewController(tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return false
    }
    public func splittableTableViewController(tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {}
    public func splittableTableViewControllerIndexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return nil
    }
    public func splittableTableViewController(tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return false
    }
}
