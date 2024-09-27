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
         return Field
     }()
    
    private let noteView: UITextView = {
         
         let Field = UITextView()
        
        Field.autocapitalizationType = .words
         Field.layer.borderWidth = 1
        Field.layer.borderColor = UIColor.gray.cgColor
        Field.backgroundColor = .gray
        Field.isHidden = false
         return Field
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textView)
        view.addSubview(noteView)
        align()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNote))
    }
    
    func align(){
        textView.frame = CGRect(x: 0,
                             y: 100,
                             width: view.frame.size.width,
                             height: 80)
        noteView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 580)
     
    }
    
    
   @objc func addNote() {
       guard let title = textView.text,let note = noteView.text, !title.isEmpty,!note.isEmpty else{
           return
       }
       presenter?.addNewData(title, note)
       
       print("add note tapped")
    }
    
    
}
