//
//  TableViewCell.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/26.
//

import UIKit
import SnapKit
import Kingfisher

final class ContactCell: UITableViewCell {

    static let id = "ContactCell"
    
    private lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
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
        
        contactImageView.image = nil
        nameLabel.text = nil
        phoneNumberLabel.text = nil
        emailLabel.text = nil
    }
    
    func configure(data: Contact) {
        contactImageView.kf.indicatorType = .activity
        contactImageView.kf.setImage(with: URL(string: "https://i.pravatar.cc/?img=\(data.id)"))
        nameLabel.text = data.name
        phoneNumberLabel.text = data.phone
        emailLabel.text = data.email
    }

}

extension ContactCell {

    private func addViews() {
        [contactImageView, verticalStackView].forEach { view in
            self.contentView.addSubview(view)
        }
        
        [nameLabel, phoneNumberLabel, emailLabel].forEach { view in
            verticalStackView.addArrangedSubview(view)
        }
    }

    private func setupLayout() {
        contactImageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.leading.equalTo(self.contentView.snp.leading).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)

            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.2)
            make.height.equalTo(self.contentView.snp.width).multipliedBy(0.2).priority(750)
        }
      
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(contactImageView.snp.top)
            make.leading.equalTo(contactImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(contactImageView.snp.bottom)
        }
    }

}
