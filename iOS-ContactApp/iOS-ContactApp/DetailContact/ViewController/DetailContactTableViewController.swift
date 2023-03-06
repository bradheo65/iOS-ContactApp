//
//  DetailContactTableViewController.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/03/02.
//

import UIKit
import SnapKit

final class DetailContactTableViewController: UITableViewController {
        
    enum Section: CaseIterable {
        case thumbnail
        case contact
        case address
        case company
    }
    
    private lazy var diffableDataSource: UITableViewDiffableDataSource<Section, AnyHashable> = .init(tableView: tableView) { (tableView, indexPath, object) -> UITableViewCell? in
        
        if let object = object as? Int {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ContactThumbnailViewCell.id,
                for: indexPath
            ) as! ContactThumbnailViewCell
            cell.configure(data: object)
            return cell
        } else if let object = object as? String {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ContactInfoViewCell.id,
                for: indexPath
            ) as! ContactInfoViewCell
            cell.configure(info: object)
            return cell
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
    }
    
    func configure(data: Contact) {
        var snapshot = diffableDataSource.snapshot()
        
        snapshot.appendSections([.thumbnail, .contact, .address, .company])
        snapshot.appendItems(
            [
                data.id
            ],
            toSection: .thumbnail
        )
        snapshot.appendItems(
            [
                data.name, data.phone, data.email
            ],
            toSection: .contact
        )
        snapshot.appendItems(
            [
                "\(data.address.street). \(data.address.suite). \(data.address.city). \(data.address.zipcode)"
            ],
            toSection: .address
        )
        snapshot.appendItems(
            [
                data.company.name, data.company.catchPhrase, data.company.bs
            ],
            toSection: .company
        )
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension DetailContactTableViewController {
    
    private func setupLayout() {
        self.tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view)
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(
            frame: view.bounds,
            style: .insetGrouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            ContactThumbnailViewCell.self,
            forCellReuseIdentifier: ContactThumbnailViewCell.id
        )
        tableView.register(
            ContactInfoViewCell.self,
            forCellReuseIdentifier: ContactInfoViewCell.id
        )
    }
    
}
