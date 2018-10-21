//
//  ViewController.swift
//  SplittableViewKitExample
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import SplittableViewKit

final class ViewController: SplittableTableViewController {

    private enum Const {
        static let cellReuseIdentifier = "Cell"
    }

    private let colors: [UIColor] = [
        .red,
        .green,
        .blue,
        .yellow,
        .white,
        .black
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        tableView.register(UINib(nibName: "ThumbnailViewCell", bundle: nil),
                           forCellReuseIdentifier: "ThumbnailViewCell")
    }
}

extension ViewController: SplittableTableViewControllerDataSource {    
    func splittableTableViewController(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "ThumbnailViewCell", for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier, for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }

    func splittableTableViewController(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    func splittableTableViewControllerWillMoveTopView(view: UIView, to leftView: UIView) {
        leftView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 0),
            view.centerYAnchor.constraint(equalTo: leftView.centerYAnchor, constant: 0)
        ])
    }
}

