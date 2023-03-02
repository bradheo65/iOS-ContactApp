//
//  ContactThumbnailViewCell.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/03/02.
//

import UIKit
import SnapKit
import Kingfisher

final class ContactThumbnailViewCell: UITableViewCell {
    
    static let id = "ContactThumbnailViewCell"
    
    private let thumbnailImageView: UIImageView = {
        let label = UIImageView()
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .systemGroupedBackground
        addViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
    }
    
    func configure(data: Int) {
        thumbnailImageView.kf.setImage(with: URL(string: "https://i.pravatar.cc/?img=\(data)"))
    }
}

extension ContactThumbnailViewCell {
    
    private func addViews() {
        self.contentView.addSubview(thumbnailImageView)
    }
    
    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.contentView)
            
            make.centerX.equalTo(self.contentView.snp.centerX)
            
            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.3)
            make.height.equalTo(self.contentView.snp.width).multipliedBy(0.3).priority(750)
        }
    }
    
}
