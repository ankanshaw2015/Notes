//
//  NotesView.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation
import UIKit

protocol NotesViewProtocol{
    var presenter: NotesPresenterProtocol? { get set }
    
    func update(with notes: [NoteInfo])
    func noData(with error: String)
  
    
}

class MyNotesViewController: UIViewController,NotesViewProtocol,UITableViewDelegate,UITableViewDataSource{

    
    
    private    let table = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
       // table.delegate = self
       // table.dataSource = self
        return table
    }()
    
    private let label: UILabel = {
        
         let label = UILabel()
        label.textAlignment = .center
        label.text = "Note"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    
    var presenter: NotesPresenterProtocol?
    
    var myNote :[ NoteInfo] = []
    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Notes"
        presenter?.viewDidLoad()
        view.backgroundColor = .yellow
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        align()
    }
    
    private func align() {
        // Add the table view and label to the main view
        view.addSubview(table)
        view.addSubview(label)
        table.backgroundColor = .yellow
        table.tintColor = .lightGray
        table.tintColor = .darkGray
      
        
        label.textColor = .lightGray
        // Set up constraints for the table view
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
        ])

        // Set up constraints for the label
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)// Fixed height of 80 points
        ])
    }
    
    func update(with notes: [NoteInfo]) {
        DispatchQueue.main.async { [self] in
            self.myNote = notes
            self.label.isHidden = true
            self.table.reloadData()
            self.table.isHidden = false
           
        }
        
    }
   @objc func didTapAdd(){
       presenter?.addNewNote()
       print("bar tap buttom tapped")
    }
    
    func noData(with error: String) {
        
        self.label.isHidden = false
        self.label.text = error
        self.table.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content = cell.defaultContentConfiguration()
        content.text = myNote[indexPath.row].noteTitle
        content.secondaryText = myNote[indexPath.row].noteData
        cell.contentConfiguration = content
        cell.contentView.backgroundColor = UIColor.systemYellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.detailNote(myNote[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete", handler: { [self]action,view,handler in
            let note = self.myNote[indexPath.row]
            self.presenter?.deleteNote(note)
        }
        )
        let confure = UISwipeActionsConfiguration(actions: [action])
        return confure
    }
    
}
