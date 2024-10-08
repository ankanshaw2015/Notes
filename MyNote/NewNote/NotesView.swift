//
//  NotesView.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation
import UIKit
import Lottie

protocol NotesViewProtocol{
    var presenter: NotesPresenterProtocol? { get set }
    
    func update(with notes: [NoteInfo])
    func noData(with error: String)
    func profile()
    func about()
    func recentlyDeleted()
}

class MyNotesViewController: UIViewController,NotesViewProtocol,UITableViewDelegate,UITableViewDataSource{
    
    var animation = false
    private var animationView: LottieAnimationView?
    
    var slideMenu:SlideMenuView?
    var isMenuOpen = false
    let searchBar = UISearchBar()
    var filteredNotes:[NoteInfo] = []
    var isSearch = false
    var addButton = UIBarButtonItem()
    var button = UIBarButtonItem()
    var slideButton = UIBarButtonItem()
    
    let text = UITextView()
    let collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
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
        return table
    }()
    
    private let label: UILabel = {
        
         let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
   // let addButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(didTapAdd))
    
    var presenter: NotesPresenterProtocol?
    
    var myNote :[ NoteInfo] = []
    var myDeletedNote : [NotesData] = []
    
    var mode = true
    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Notes"
        presenter?.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
        loadingButtons()
        //addTapGesture()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setSearchBar()
        text.isHidden = true
        setupOverlay()
    
        align()
    }
    
    
    private func addTapGesture() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDrawer))
           self.view.addGestureRecognizer(tapGesture)
       }
       
       @objc private func dismissDrawer() {
           if isMenuOpen {
               UIView.animate(withDuration: 0.3) {
                   self.slideMenu?.view.frame = CGRect(x: 0, y: 0, width: -300, height: self.view.frame.height)// Move off-screen
               }
               isMenuOpen = false
           }
       }
 
    override func viewDidAppear(_ animated: Bool) {
    
        
        if animation {
            loadSaveAnimation()
        }
        
    }
    
    func loadingButtons(){
        addButton = UIBarButtonItem(image: UIImage(systemName: "note.text.badge.plus"), style: .plain, target: self, action: #selector(didTapAdd))

               // addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))

               let gridIcon = UIImage(named: "grid")
               
               button = UIBarButtonItem(image: gridIcon, style: .plain, target: self, action: #selector(toggle))
               
               slideButton = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .plain, target: self, action: #selector(slideButtonTapped))
        
               navigationItem.rightBarButtonItems = [addButton, button,slideButton]
               print("buttons are loading")
    }
    
    func loadSaveAnimation(){
        animationView = .init(name: "saved")
          
        animationView!.frame = CGRect(x: Int(view.frame.width/2 - 80), y: Int((view.frame.height/2) - 80), width: 150, height: 150)
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        animationView!.loopMode = .playOnce
          
          // 5. Adjust animation speed
          
        animationView!.animationSpeed = 1.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
        animationView!.play{completed in
            self.animationView!.removeFromSuperview()
        }
        
        animation = false
    }
    
    func loadDeleteAnimation(){
        animationView = .init(name: "deleteButton")
          
        animationView!.frame = CGRect(x: Int(view.frame.width/2 - 80), y: Int((view.frame.height/2) - 80), width: 150, height: 150)
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        animationView!.loopMode = .playOnce
          
          // 5. Adjust animation speed
          
        animationView!.animationSpeed = 1.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
        animationView!.play{completed in
            self.animationView!.removeFromSuperview()
        }
        
    }
    
    private let overlayView = UIView()
    private func setupOverlay() {
           // Configure the overlay view
           overlayView.frame = self.view.bounds
           overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.0) // Semi-transparent
           overlayView.isHidden = true // Start hidden
           overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(slideButtonTapped)))
           self.view.addSubview(overlayView)
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
            self.overlayView.isHidden = false
        }
        else{
            self.overlayView.isHidden = true
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
        delete = false
        table.isHidden = true
        collectionView.isHidden = true
        button.isHidden = true
        addButton.isHidden = true
       
        searchBar.isHidden = true
        text.isHidden = false
        navigationItem.leftBarButtonItem = slideButton
        isMenuOpen = false
        text.text = constant().texts
                text.backgroundColor =  UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 1)
                text.layer.cornerRadius = 18
        text.font = .systemFont(ofSize: 16, weight: .light)
        
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
        })
    }
    
    func profile(){
        delete = false
        table.isHidden = true
        searchBar.isHidden = false
        if myNote.isEmpty || myNote[0].noteTitle == nil{
            collectionView.isHidden = true
            collectionView.reloadData()
            label.isHidden = false
        }
        else{
            collectionView.isHidden = false
            collectionView.reloadData()
        }
       // collectionView.isHidden = false
        button.isHidden = false
        addButton.isHidden = false
//        if myNote.isEmpty{
//            label.isHidden = false
//        }
        
        searchBar.isHidden = false
        text.isHidden = true
        isMenuOpen = false
        table.reloadData()
       // collectionView.reloadData()
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
          
        })
        navigationItem.leftBarButtonItem?.isHidden = false
       // print(myNote[0].noteTitle)
    }
    
    var delete = false
    
    func recentlyDeleted(){
        text.isHidden = true
        searchBar.isHidden = true
        delete = true
        isMenuOpen = false
        collectionView.isHidden = true
        label.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        navigationItem.leftBarButtonItem = slideButton
        button.isHidden = true
        table.isHidden = false
        table.reloadData()
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.slideMenu!.view.frame = CGRect(x: -250, y: 0, width: 0, height: 0)
        })
       // print(myDeletedNote[myDeletedNote.count - 1] , myDeletedNote.count)
    }
    
    
    

    
    @objc func toggle() {
            if table.isHidden {
              
                table.isHidden = false
                collectionView.isHidden = true
                table.reloadData()
                navigationItem.rightBarButtonItems![1].image = UIImage(named: "list")
                
            } else {
              
                collectionView.isHidden = false
                table.isHidden = true
               // collectionView.isHidden = false
                collectionView.reloadData()
                navigationItem.rightBarButtonItems![1].image = UIImage(named: "grid")
            }
        }
    
    
       private func align() {
           view.addSubview(collectionView)
           view.addSubview(table)
           view.addSubview(label)

           table.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1.0)
           table.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               table.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 5),
               table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])

           collectionView.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1.0)
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
          // text.text = "achha app hai"
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
            collectionView.isHidden = false
           
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
        return delete ? myDeletedNote.count : isSearch ? filteredNotes.count : myNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content = cell.defaultContentConfiguration()
        content.text = delete ? myDeletedNote[indexPath.row].noteTitle : isSearch ? filteredNotes[indexPath.row].noteTitle : myNote[indexPath.row].noteTitle
        content.secondaryText = delete ? myDeletedNote[indexPath.row].noteData : isSearch ? filteredNotes[indexPath.row].noteData : myNote[indexPath.row].noteData
        cell.contentConfiguration = content
        cell.contentView.backgroundColor = UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if delete{
            let sheet  = UIAlertController(title: "Do You Want to Restore?", message: nil, preferredStyle: .actionSheet)
                   sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                   sheet.addAction(UIAlertAction(title: "Restore", style: .default, handler: { _ in
                       self.presenter?.interactor?.myNote = self.myDeletedNote[indexPath.row]
                       self.myDeletedNote.remove(at: indexPath.row)
                       self.presenter?.viewDidLoad()
                       //self.myDeletedNote.remove(at: indexPath.row)
                       
                           }

                   ))
                   present(sheet, animated: true)
        }
        
        presenter?.detailNote(myNote[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete", handler: { [self]action,view,handler in
            let note = self.myNote[indexPath.row]
           // var noteData:NotesData
            if !delete{
                let noteData = NotesData(noteTitle: note.noteTitle! , noteData: note.noteData!)
                print(noteData.noteData)
                print(note.noteData!)
                myDeletedNote.insert(noteData, at: myDeletedNote.count)
                presenter?.deleteNote(note)
            }
            
            else{
                myDeletedNote.remove(at: indexPath.row )
                table.reloadData()
            }
           print(delete)
            
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
        cell.backgroundColor = UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 1.0)
        cell.button.tag = indexPath.item // Tag the button with the index
        cell.button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
          let index = sender.tag
        if !delete{
            let noteData = NotesData(noteTitle:myNote[index].noteTitle! ,
                                     noteData: myNote[index].noteData!)
            myDeletedNote.append(noteData)
        }
        presenter?.deleteNote(myNote[index])
        print(myDeletedNote.count)
        print(myDeletedNote[myDeletedNote.count - 1].noteTitle, "data")
        loadDeleteAnimation()
          collectionView.reloadData()
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
        self.backgroundColor = UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 0.6)
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
        
        text.backgroundColor = UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 0.3)
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
        self.layer.cornerRadius = 15
        self.layer.shadowRadius = 4
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
        
        UISearchBar.appearance().backgroundImage = UIImage() // This removes the default background
        UISearchBar.appearance().barTintColor = UIColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 0.6) // Set the bar tint color

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
