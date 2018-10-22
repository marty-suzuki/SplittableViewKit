//
//  SplittableTableViewDataSourceProxy.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/22.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

protocol SplittableTableViewDataSourceProxyDataSource: AnyObject {
    func proxy(tableView: UITableView, cellForRowAt indexPath: IndexPath, cell: UITableViewCell) -> UITableViewCell
}

final class SplittableTableViewDataSourceProxy: _NSObjectProxy, SplittableTableViewDataSource {

    var dataSource: SplittableTableViewDataSource? {
        set {
            _object = newValue
        }
        get {
            return _object as? SplittableTableViewDataSource
        }
    }

    private weak var proxy: SplittableTableViewDataSourceProxyDataSource?

    init(proxy: SplittableTableViewDataSourceProxyDataSource) {
        self.proxy = proxy
    }


    func splittableViewForLeftView(topView: UIView) -> UIView {
        return dataSource?.splittableViewForLeftView(topView: topView) ?? Undefined.object()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? Undefined.object()
        return proxy?.proxy(tableView: tableView, cellForRowAt: indexPath, cell: cell) ?? Undefined.object()
    }
}
