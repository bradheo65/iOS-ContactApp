//
//  ContactInfoViewCell.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/03/02.
//

import UIKit
import SnapKit

final class ContactInfoViewCell: UITableViewCell {
    
    static let id = "ContactInfoViewCell"

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoLabel.text = ""
    }
    
    func configure(info: String) {
        infoLabel.text = info
    }
    
}

extension ContactInfoViewCell {
    
    private func addViews() {
        self.contentView.addSubview(infoLabel)
    }
    
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.contentView).offset(10)
            make.trailing.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
}
