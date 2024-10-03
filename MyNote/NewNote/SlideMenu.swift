//
//  SlideMenu.swift
//  MyNote
//
//  Created by Yashom on 02/10/24.
//

import Foundation

import UIKit

class SlideMenuView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var email:String?
    var present:NotesPresenterProtocol?
    let image = UIImageView()
    let tableView = UITableView()
    let menuItems = ["Profile", "About", "Log Out"]
    let label = UILabel()
    let about = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("side menu")
        setupMenu()
        setupTableView()
        
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 250) // Menu width
        ])
    }

    func setupMenu() {
        view.addSubview(image)
        label.text = email
        label.backgroundColor = .white
        
        view.addSubview(label)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        print(email ?? "no mail")
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2),
                   label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
                   label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1)
            
        ])
        
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            image.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }

    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            present?.profileView()
            print("profile")
        case 1:
            present?.aboutView()
            print("about")
        case 2:
            present!.goToSignUp()
            print("signup ")
        default:
            break
        }
    }
}
