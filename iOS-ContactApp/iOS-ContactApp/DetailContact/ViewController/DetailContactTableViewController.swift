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
        var snapshot = self.diffableDataSource.snapshot()
        
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
                data.address.street, data.address.suite, data.address.city, data.address.zipcode
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let contactHeaderView = ContactHeaderView()
        
        if section == 1 {
            contactHeaderView.configure(with: "Contact")
            return contactHeaderView
        } else if section == 2 {
            contactHeaderView.configure(with: "Address")
            return contactHeaderView
        } else if section == 3 {
            contactHeaderView.configure(with: "Company")
            return contactHeaderView
        }
        
        return UIView()
    }
    
}

extension DetailContactTableViewController {
    
    private func setupLayout() {
        self.tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.view)
        }
    }
    
    private func setupTableView() {
        self.tableView = UITableView(
            frame: view.bounds,
            style: .insetGrouped
        )
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.register(
            ContactThumbnailViewCell.self,
            forCellReuseIdentifier: ContactThumbnailViewCell.id
        )
        self.tableView.register(
            ContactInfoViewCell.self,
            forCellReuseIdentifier: ContactInfoViewCell.id
        )
        self.tableView.register(
            ContactHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ContactHeaderView.id
        )
    }
    
}
