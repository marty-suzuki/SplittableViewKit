//
//  SplittableTableViewDelegateProxy.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/22.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

protocol SplittableTableViewDelegateProxyDelegate: AnyObject {
    func proxy(tableView: UITableView, heightForRowAt indexPath: IndexPath, height: CGFloat) -> CGFloat
}

final class SplittableTableViewDelegateProxy: _NSObjectProxy, SplittableTableViewDelegate {

    var delegate: SplittableTableViewDelegate? {
        set {
            _object = newValue
        }
        get {
            return _object as? SplittableTableViewDelegate
        }
    }

    private weak var proxy: SplittableTableViewDelegateProxyDelegate?

    init(proxy: SplittableTableViewDelegateProxyDelegate) {
        self.proxy = proxy
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #if swift(>=4.2)
        let  automaticDimension: CGFloat = UITableView.automaticDimension
        #else
        let  automaticDimension: CGFloat = UITableViewAutomaticDimension
        #endif
        
        let height = delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? automaticDimension
        return proxy?.proxy(tableView: tableView, heightForRowAt: indexPath, height: height) ?? automaticDimension
    }
}
