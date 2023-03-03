//
//  ContactHeaderView.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/03/03.
//

import UIKit
import SnapKit

final class ContactHeaderView: UITableViewHeaderFooterView {
    
    static let id = "ContactHeaderView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}

extension ContactHeaderView {
    
    private func addViews() {
        self.contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.contentView).offset(10)
            make.trailing.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
}
