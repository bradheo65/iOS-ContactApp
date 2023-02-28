//
//  MainViewController.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()

    private var contactData: [Contact] = []
    private var filterContactData: [Contact] = []
    
    private var isFiltering: Bool {
        let serarchController = self.navigationItem.searchController
        let isActive = serarchController?.isActive ?? false
        let isSearchBarHasText = serarchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupLayout()
        setupNavigationBar()
        setupSearchController()
        setupRefreshControl()
        setupTableView()
        fetchItem()
    }

}

extension MainViewController {

    private func addViews() {
        self.view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "My Contact"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Contact"
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.id)
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    private func fetchItem() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
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
                        self.tableView.reloadData()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("HTTP URL Response code: \(response.statusCode)")
            }
        }.resume()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filterContactData.count : contactData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.id, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        if isFiltering {
            cell.configure(data: filterContactData[indexPath.row])
        } else {
            cell.configure(data: contactData[indexPath.row])
        }
        
        return cell
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        filterContactData = contactData.filter {
            $0.name.localizedCaseInsensitiveContains(text)
        }
    }
    
}
