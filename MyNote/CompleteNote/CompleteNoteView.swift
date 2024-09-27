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
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "My Note"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let text: UITextView = {
        
        let label = UITextView()
        label.textAlignment = .center
        label.text = ""
        label.font = .systemFont(ofSize: 26, weight: .light)
        return label
    }()
    
    

    
    //***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.addSubview(label)
        view.addSubview(text)
        align()
        view.backgroundColor = .cyan
    }
    
    
    func align(){
        label.frame = CGRect(x: 0,
                             y: 100,
                             width: view.frame.size.width,
                             height: 80)
        text.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 300)
     
    }
    
    func update(with note: NotesData) {
        label.text = note.noteTitle
        text.text = note.noteInfo
    }
    

    
    
}
    
