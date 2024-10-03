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
    func profile()
    func about()
    
}

class MyNotesViewController: UIViewController,NotesViewProtocol,UITableViewDelegate,UITableViewDataSource{
    
    var slideMenu:SlideMenuView?
    var isMenuOpen = false
    let searchBar = UISearchBar()
    var filteredNotes:[NoteInfo] = []
    var isSearch = false
    
    let text = UITextView()
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
        setSearchBar()
        text.isHidden = true
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
       // setupTapGesture()
    }
    var addButton = UIBarButtonItem()
    var button = UIBarButtonItem()
    var slideButton = UIBarButtonItem()
    override func viewDidAppear(_ animated: Bool) {
         addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
           // Create the grid or list button
        let gridIcon = UIImage(named: "grid")
        
        button = UIBarButtonItem(image: gridIcon, style: .plain, target: self, action: #selector(toggle))
       // let signOut = UIBarButtonItem(title: "grid", style: .plain, target: self, action: #selector(signUpTapped))
        
         slideButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(slideButtonTapped))
        
      //  let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [addButton, button,slideButton]
        print("buttons are loading")
    }
    
    @objc func slideButtonTapped(){

        let slideMenu = self.slideMenu!
        addChild(slideMenu)
        view.addSubview(slideMenu.view)
        
        if !isMenuOpen{
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                self.slideMenu!.view.frame = CGRect(x: 0, y: 0, width: 250, height: self.view.frame.height)
            })
            slideMenu.didMove(toParent: self)
            isMenuOpen = true
        }
        else{
           
            UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveEaseInOut], animations: {

                self.slideMenu?.view.alpha = 0.0
                if let slideMenuFrame = self.slideMenu?.view.frame {
                    self.slideMenu!.view.frame = CGRect(x: -slideMenuFrame.width, y: 0, width: slideMenuFrame.width, height: slideMenuFrame.height)
                }
            }, completion: { finished in

                self.slideMenu?.view.alpha = 1.0 // Reset alpha if needed
            })
            slideMenu.didMove(toParent: self)
            
            print("menu closed")
            isMenuOpen = false
        }
        
    }
    
    func about(){
        table.isHidden = true
        collectionView.isHidden = true
        button.isHidden = true
        addButton.isHidden = true
        //.backgroundColor = .systemBlue
        searchBar.isHidden = true
        text.isHidden = false
        navigationItem.leftBarButtonItem = slideButton
        isMenuOpen = false
        
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
           // slideMenu.view.removeFromSuperview()
        })
    }
    
    func profile(){
        table.isHidden = false
       // collectionView.isHidden = false
        button.isHidden = false
        addButton.isHidden = false
        view.backgroundColor = .yellow
        searchBar.isHidden = false
        text.isHidden = true
        isMenuOpen = false
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
           // slideMenu.view.removeFromSuperview()
        })
    }
//    func setupTapGesture() {
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
//        view.addGestureRecognizer(tapGesture)
//    }
//
//
//    @objc func handleBackgroundTap() {
//        if isMenuOpen {
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
//                self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
//            })
//
            
//            print("menu closed")
//            isMenuOpen = false
//        }
//    }
    
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
               table.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 5),
               table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])

           collectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])

           label.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])

          
           table.isHidden = true
           
           text.translatesAutoresizingMaskIntoConstraints = false
           text.backgroundColor = .systemBlue
           text.text = "achha app hai"
           view.addSubview(text)
           NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               text.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               text.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               text.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])
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
        self.collectionView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? filteredNotes.count : myNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content = cell.defaultContentConfiguration()
        content.text = isSearch ? filteredNotes[indexPath.row].noteTitle : myNote[indexPath.row].noteTitle
        content.secondaryText =  isSearch ? filteredNotes[indexPath.row].noteData : myNote[indexPath.row].noteData
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
        return isSearch ? filteredNotes.count : myNote.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! noteCell
       let noteItem = isSearch ? filteredNotes[indexPath.item] : myNote[indexPath.item]
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

extension MyNotesViewController:UISearchBarDelegate{
  
    func setSearchBar(){
        searchBar.placeholder = "search note"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .yellow
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchBar.leftAnchor.constraint(equalTo: view.leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearch = false
            filteredNotes.removeAll()
            table.reloadData()
            collectionView.reloadData()
        }else{
            isSearch = true
            filteredNotes = myNote.filter{
               return $0.noteTitle!.lowercased().contains(searchText.lowercased())
            }
            table.reloadData()
            collectionView.reloadData()
        }
    }
}
