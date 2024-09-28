//
//  NewNoteView.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation
import UIKit

protocol NewNoteViewProtocol{
    
    var presenter : NewNotePresenterProtocol?{get set}
    func addNote()
    
}
protocol NewNoteData{
    
}

class NewNoteViewController:UIViewController,NewNoteViewProtocol{
    var presenter: NewNotePresenterProtocol?
    
    private let textView: UITextField = {
         
         let Field = UITextField()
         Field.placeholder = "Give A Title"
        Field.autocapitalizationType = .none
         Field.layer.borderWidth = 1
        Field.layer.borderColor = UIColor.gray.cgColor
         Field.leftViewMode = .always
        Field.isHidden = false
        Field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        Field.backgroundColor = .systemYellow
         return Field
     }()
    
    private let noteView: UITextView = {
         
         let Field = UITextView()
        
        Field.autocapitalizationType = .words
         Field.layer.borderWidth = 1
        Field.layer.borderColor = UIColor.systemYellow.cgColor
        Field.backgroundColor = .systemYellow
        Field.isHidden = false
         return Field
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(textView)
        view.addSubview(noteView)
        align()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNote))
    }
    
    func align(){
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor , constant: 120),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //textView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -20)
            textView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        noteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noteView.topAnchor.constraint(equalTo: textView.bottomAnchor , constant: 20),
            noteView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -20)
        ])

     
    }
    
    
   @objc func addNote() {
       guard let title = textView.text,let note = noteView.text, !title.isEmpty,!note.isEmpty else{
           return
       }
       presenter?.addNewData(title, note)
       
       print("add note tapped")
    }
    
    
}
