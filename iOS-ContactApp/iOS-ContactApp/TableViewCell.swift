//
//  TableViewCell.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/26.
//

import UIKit

final class TableViewCell: UITableViewCell {

    static let id = "TableViewCell"

    var numberLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: String) {
        numberLable.text = data
    }

}

extension TableViewCell {

    private func addViews() {
        self.contentView.addSubview(numberLable)
    }

    private func setLayouts() {

        NSLayoutConstraint.activate([
            numberLable.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            numberLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            numberLable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            numberLable.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

}
