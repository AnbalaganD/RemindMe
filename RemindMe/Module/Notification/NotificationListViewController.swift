//
//  NotificationListViewController.swift
//  RemindMe
//
//  Created by Anbalagan on 30/06/24.
//

import UIKit

final class NotificationListViewController: UIViewController {
    private var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
        registerCells()
        setupSource()
    }
    
    @objc private func showFilterOption() {
        print(#function)
        
        let categoryFilterViewController = CategoryFilterViewController()
        categoryFilterViewController.modalPresentationStyle = .formSheet
        
        if let sheet = categoryFilterViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        present(categoryFilterViewController, animated: true)
    }
    
    @objc private func createNotification() {
        present(
            UINavigationController(rootViewController: CreateNotificationViewController()),
            animated: true
        )
    }
}

private extension NotificationListViewController {
    func setupView() {
        title = "Notification"
        view.backgroundColor = .white
        
        notificationTableView = UITableView(frame: .zero)
        notificationTableView.translatesAutoresizingMaskIntoConstraints = false
        notificationTableView.separatorStyle = .none
        notificationTableView.backgroundColor = .clear
        view.addSubview(notificationTableView)
        
        notificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notificationTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func registerCells() {
        notificationTableView.register(
            NotificationCell.self,
            forCellReuseIdentifier: NotificationCell.cellIdentifier
        )
    }
    
    func setupSource() {
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .plain,
                target: self,
                action: #selector(createNotification)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "line.3.horizontal.decrease"),
                style: .plain,
                target: self,
                action: #selector(showFilterOption)
            )
        ]
    }
}

extension NotificationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NotificationCell.cellIdentifier,
            for: indexPath
        ) as! NotificationCell
        
        cell.setupData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            NotificationDetailsController(),
            animated: true
        )
    }
}
