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
    }
    
    private lazy var diffableDataSource: UITableViewDiffableDataSource<Section, AnyHashable> = .init(tableView: tableView) { (tableView, indexPath, object) -> UITableViewCell? in
        
        if let object = object as? Contact {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ContactThumbnailViewCell.id,
                for: indexPath
            ) as! ContactThumbnailViewCell
            
            cell.configure(data: object.id)
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
        guard let data = data as? AnyHashable else { return }
        var snapshot = self.diffableDataSource.snapshot()
        
        snapshot.appendSections([.thumbnail])
        snapshot.appendItems([data], toSection: .thumbnail)
        
        diffableDataSource.apply(snapshot, animatingDifferences: true)
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
    }
    
}
