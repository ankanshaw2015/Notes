//
//  CompleteNoteView.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation
import UIKit

protocol CompleteNoteViewProtocol{
    var presenter: CompleteNotePresenterProtocol?{get set}
        
   // func update(with note:NotesData)
    func update(with note:NoteInfo)
}

class CompleteNoteViewController: UIViewController,CompleteNoteViewProtocol{
    var presenter: CompleteNotePresenterProtocol?
    
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "My Note"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private var text: UITextView = {
        
        let label = UITextView()
        label.textAlignment = .left
        label.text = ""
        label.font = .systemFont(ofSize: 26, weight: .light)
        label.backgroundColor = .yellow
        label.isEditable = false
        return label
    }()
    
    
    var editable = true
    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        presenter?.viewDidLoad()
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItems = [edit]

        align()
        
    }
    
    @objc func editButtonTapped(){
        if editable{
            navigationItem.rightBarButtonItems![0] = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editButtonTapped))
            text.isEditable = true
            text.becomeFirstResponder() 
            editable = false
        }else{
            navigationItem.rightBarButtonItems![0] = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
            presenter?.editing(text: text.text)
            text.isEditable = false
            editable = true
        }
    }
    
    
    func align(){
        view.addSubview(label)
        view.addSubview(text)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant:  100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
     
    }
    
    func update(with note: NoteInfo) {
        label.text = note.noteTitle
        text.text = note.noteData
    }
    

    
    
}
    
