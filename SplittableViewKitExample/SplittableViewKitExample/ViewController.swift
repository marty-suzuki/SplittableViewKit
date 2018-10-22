//
//  ViewController.swift
//  SplittableViewKitExample
//
//  Created by marty-suzuki on 2018/10/21.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import SplittableViewKit

final class ViewController: UIViewController {

    private enum Const {
        static let cellReuseIdentifier = "Cell"
    }

    @IBOutlet weak var splittableTableView: SplittableTableView!

    private enum RowStyle {
        case thumbnail
        case title
        case introduction
        case information
    }

    private let rows: [RowStyle] = [
        .thumbnail,
        .title,
        .introduction,
        .information
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        splittableTableView.dataSource = self
        splittableTableView.rightView.register(UITableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        splittableTableView.rightView.register(UINib(nibName: "ThumbnailViewCell", bundle: nil),
                                               forCellReuseIdentifier: "ThumbnailViewCell")
        splittableTableView.rightView.register(UINib(nibName: "TitleViewCell", bundle: nil),
                                               forCellReuseIdentifier: "TitleViewCell")

        splittableTableView.rightView.register(UINib(nibName: "IntroductionViewCell", bundle: nil),
                                               forCellReuseIdentifier: "IntroductionViewCell")

        splittableTableView.rightView.register(UINib(nibName: "InformationViewCell", bundle: nil),
                                               forCellReuseIdentifier: "InformationViewCell")
    }
}

extension ViewController: SplittableTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case .thumbnail:
            return tableView.dequeueReusableCell(withIdentifier: "ThumbnailViewCell", for: indexPath)
        case .title:
            return tableView.dequeueReusableCell(withIdentifier: "TitleViewCell", for: indexPath)

        case .introduction:
            return tableView.dequeueReusableCell(withIdentifier: "IntroductionViewCell", for: indexPath)

        case .information:
            return tableView.dequeueReusableCell(withIdentifier: "InformationViewCell", for: indexPath)
        }
    }

    func splittableViewForLeftView(topView: UIView) -> UIView {
        let view = UIView(frame: .zero)
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            view.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0)
        ])
        return view
    }
}

