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
    
    private var contactData: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setLayouts()
        tableViewSetting()
        fetchItem()
    }

}

extension MainViewController {

    private func addViews() {
        self.view.addSubview(tableView)
    }

    private func setLayouts() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    private func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.id)
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
        return contactData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.id, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        cell.configure(data: contactData[indexPath.row])
        
        return cell
    }
    
}

