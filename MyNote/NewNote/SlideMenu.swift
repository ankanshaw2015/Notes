//
//  SlideMenu.swift
//  MyNote
//
//  Created by Yashom on 02/10/24.
//

import Foundation

import UIKit
import Lottie

class SlideMenuView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var image: LottieAnimationView?
    var email:String?
    var present:NotesPresenterProtocol?
   // let image = UIImageView()
    let tableView = UITableView()
    let menuItems = ["Home","Recently Deleted", "About", "Log Out"]
    let label = UILabel()
    let about = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 0.08)
        print("side menu")
        label.text = email
        loadProfile()
        setupMenu()
        setupTableView()
        view.layer.shadowColor = CGColor(gray: 1, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 3
    }
    
    
    
    func loadProfile(){
        image = .init(name: "userIcon")
          
        image!.frame = CGRect(x: Int(view.frame.width/2 - 80), y: Int((view.frame.height/2) - 80), width: 150, height: 150)
          
          // 3. Set animation content mode
          
          image!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        image!.loopMode = .loop
          
          // 5. Adjust animation speed
          
        image!.animationSpeed = 1.5
          
          view.addSubview(image!)
          
          // 6. Play animation
          
        image!.play()
        
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1)
        
        
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
//        view.addSubview(image)
//        label.text = email
//        label.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1)
        
        view.addSubview(label)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        print(email ?? "no mail")
        label.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: image!.bottomAnchor, constant: 2),
                   label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
                   label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1)
            
        ])
        
//        image.image = UIImage(named: "user")
        image!.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1)
       // image!.contentMode = .scaleAspectFill
        image!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image!.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            image!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            image!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            image!.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1)
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
            present?.recentDelete()
            print("deleted")
        case 2:
            present?.aboutView()
            print("about")
        case 3:
            present!.goToSignUp()
            print("signup ")
        default:
            break
        }
    }
}
