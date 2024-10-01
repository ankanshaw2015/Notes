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

    let collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            // Set item size, spacing, etc. (customize as needed)
           // layout.itemSize = CGSize(width: 170, height: 600)
        
           // layout.minimumLineSpacing = 10
           // layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(noteCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .lightGray
        return collection
        
    }()
    
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
    
   // let addButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(didTapAdd))
    
    var presenter: NotesPresenterProtocol?
    
    var myNote :[ NoteInfo] = []
    
    var mode = true
    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Notes"
        presenter?.viewDidLoad()
        view.backgroundColor = .yellow
        table.dataSource = self
        table.delegate = self
        table.reloadData()
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
       // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
//
//
//        let gridIcon = UIImage(named: "grid")
//
//        let button = UIBarButtonItem(image: gridIcon, style: .plain, target: self, action: #selector(toggle))
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
//
//
//           navigationItem.rightBarButtonItems = [addButton, button,refresh]
        align()
    }
    override func viewDidAppear(_ animated: Bool) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
           
           // Create the grid or list button
        let gridIcon = UIImage(named: "grid")
        
        let button = UIBarButtonItem(image: gridIcon, style: .plain, target: self, action: #selector(toggle))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [addButton, button,refresh]
        print("buttons are loading")
    }
    
    @objc func refreshTapped(){
//        table.reloadData()
//        collectionView.reloadData()
        let router = LogInRouter.routing()
        let entryViewController = router.entry // Replace with your actual entry view controller class

           // Get the SceneDelegate
           if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
               // Access the window safely
               if let window = sceneDelegate.window {
                   // Set the root view controller
                   window.rootViewController = entryViewController
                   
                   // Optionally add a transition animation
                   UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                       window.rootViewController = entryViewController
                   }, completion: nil)
                   
                   window.makeKeyAndVisible()
               }
           }
    }
    
    @objc func toggle() {
            if table.isHidden {
                table.isHidden = false
                collectionView.isHidden = true
                navigationItem.rightBarButtonItems![1].image = UIImage(named: "list")
                
            } else {
                table.isHidden = true
                collectionView.isHidden = false
                navigationItem.rightBarButtonItems![1].image = UIImage(named: "grid")
            }
        }
    
    
       private func align() {
           view.addSubview(collectionView)
           view.addSubview(table)
           view.addSubview(label)

           table.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])

           collectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])

           label.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])

           // Initially hide the table view
           table.isHidden = true
       }
       
    
    func update(with notes: [NoteInfo]) {
        DispatchQueue.main.async { [self] in
            self.myNote = notes
            self.label.isHidden = true
            self.table.reloadData()
            self.collectionView.reloadData()
           
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


extension MyNotesViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNote.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! noteCell
       let noteItem = myNote[indexPath.item]
        cell.note = noteItem
        cell.backgroundColor = .yellow
        cell.button.tag = indexPath.item // Tag the button with the index
        cell.button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
          let index = sender.tag // Get the index from the button's tag
        presenter?.deleteNote(myNote[index])
          // Optionally, adjust tags for remaining buttons
          collectionView.reloadData() // Or update tags manually
      }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2) - 16, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.detailNote(myNote[indexPath.item])
    }
    
    
}

class noteCell:UICollectionViewCell{
    
    var note :NoteInfo?{
        didSet{
            guard let noteTitle = note?.noteTitle, let noteData = note?.noteData else{
                return
            }
            label.text = noteTitle
            text.text = noteData
        }
    }
    
    private let label: UILabel = {
        
         let label = UILabel()
        label.textAlignment = .center
        label.text = "Note"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let text : UITextView = {
        let text = UITextView()
        text.textAlignment = .left
        text.text = "complete data"
        text.isEditable = false
        return text
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
               button.translatesAutoresizingMaskIntoConstraints = false
               // Set the image for the button
               button.setImage(UIImage(systemName: "trash"), for: .normal) // Using SF Symbols
               // Set the button's tint color
               button.tintColor = .red
               // Optional: Add target action for button tap
            //   button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
               return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        self.backgroundColor = .yellow
        print("cell")
        constrain()
        shadow()
        
    }
    
    func constrain(){
        self.addSubview(label)
        self.addSubview(text)
        self.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            text .bottomAnchor.constraint(equalTo: self.bottomAnchor),
            text.leftAnchor.constraint(equalTo: self.leftAnchor),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
           // button .bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    func shadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 1
        self.clipsToBounds = false
    }
    
  @objc  func deleteButtonTapped(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
