//
//  ContactThumbnailViewCell.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/03/02.
//

import UIKit
import SnapKit

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
        
        contentView.backgroundColor = .systemGroupedBackground
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
        let request = URLRequest(url: URL(string: "https://i.pravatar.cc/?img=\(data)")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = .init(systemName: "xmark")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        task.resume()
    }
}

extension ContactThumbnailViewCell {
    
    private func addViews() {
        contentView.addSubview(thumbnailImageView)
    }
    
    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            
            make.centerX.equalTo(contentView.snp.centerX)
            
            make.width.equalTo(contentView.snp.width).multipliedBy(0.3)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.3).priority(750)
        }
    }
    
}
