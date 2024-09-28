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
        
    func update(with note:NotesData)
}

class CompleteNoteViewController: UIViewController,CompleteNoteViewProtocol{
    var presenter: CompleteNotePresenterProtocol?
    
    
//    let stackView:UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [label])
//        stackView.axis = .vertical // Stack vertically
//        stackView.spacing = 10 // Space between items
//        stackView.alignment = .center // Center align items
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "My Note"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private let text: UITextView = {
        
        let label = UITextView()
        label.textAlignment = .left
        label.text = ""
        label.font = .systemFont(ofSize: 26, weight: .light)
        label.backgroundColor = .yellow
        label.isEditable = false
        return label
    }()
    
    

    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        presenter?.viewDidLoad()

        align()
        
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
    
    func update(with note: NotesData) {
        label.text = note.noteTitle
        text.text = note.noteInfo
    }
    

    
    
}
    
