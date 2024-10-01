//
//  CompleteNotePresenter.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation

protocol CompleteNotePresenterProtocol{
    
    var view :CompleteNoteViewProtocol?{get set}
    var interactor : CompleteNoteInteractorProtocol?{get set}
    var router : CompleteNoteRouterProtocol?{get set}
    
    func viewDidLoad()
    func updateData(note:NoteInfo?)
    func editing(text:String)
    
}

class CompleteNotePresenter: CompleteNotePresenterProtocol{

    var view: CompleteNoteViewProtocol?
    
    var interactor: CompleteNoteInteractorProtocol?
    
    var router: CompleteNoteRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getNote()
    }
    
    func updateData(note: NoteInfo?) {
        if let note = note{
            view?.update(with: note)
           // print(note.noteTitle," found data")
        }else {
            print("error occurd when fetching")
        }
        
    }
    func editing(text:String) {
        interactor?.note?.noteData = text
        interactor?.getNote()
        interactor?.addEditedText()
    }
    
    
    
}
