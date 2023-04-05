//
//  MainViewController.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, Contact>!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()

    private var contactData: [Contact] = []
    private var filterContactData: [Contact] = []
    private var attributeString: String = ""

    private var isFiltering: Bool {
        let serarchController = navigationItem.searchController
        let isActive = serarchController?.isActive ?? false
        let isSearchBarHasText = serarchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        setupConfigure()
        fetchItem()
    }

}

extension MainViewController {

    private func setupConfigure() {
        setupLayout()
        setupNavigationBar()
        setupSearchController()
        setupRefreshControl()
        setupTableView()
        setupTableViewDiffableDataSource()
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "My Contact"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Contact"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchItem()
            refresh.endRefreshing()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.id)
    }
    
    private func setupTableViewDiffableDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView) { (tableView, indexPath, object) -> UITableViewCell? in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.id, for: indexPath) as? ContactCell else {
                return nil
            }
            if self.isFiltering {
                cell.configure(data: self.filterContactData[indexPath.row])
            } else {
                cell.configure(data: self.contactData[indexPath.row])
            }
            return cell
        }
    }

    private func fetchItem() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let fetchedItems = try JSONDecoder().decode([Contact].self, from: data)
                        self.contactData = fetchedItems
                        
                        var snapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
                        snapshot.appendSections([.main])
                        
                        snapshot.appendItems(self.contactData)
                        self.dataSource.apply(snapshot, animatingDifferences: true)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("HTTP URL Response code: \(response.statusCode)")
            }
        }.resume()
    }
    
    func performQuery(with filter: String?) {
        let filterItem = self.contactData.filter { $0.name.hasPrefix(filter ?? "") }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(filterItem)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension MainViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailContentViewController = DetailContactTableViewController()
        
        if isFiltering {
            navigationController?.pushViewController(detailContentViewController, animated: true)
            detailContentViewController.configure(data: filterContactData[indexPath.row])
        } else {
            navigationController?.pushViewController(detailContentViewController, animated: true)
            detailContentViewController.configure(data: contactData[indexPath.row])
        }
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        filterContactData = contactData.filter {
            $0.name.hasPrefix(text)
        }
        performQuery(with: text)
    }
    
}
