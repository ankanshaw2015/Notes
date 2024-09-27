//
//  NewNotePresenter.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation

protocol NewNotePresenterProtocol{
    var view:NewNoteViewProtocol?{get set}
    var interactor:NewNoteInteractorProtocol?{get set}
    var router:NewNoteRouterProtocol?{get set}
    
    func addNewData(_ noteTitle:String,_ noteInfo:String)
    
}

class NewNotePresenter:NewNotePresenterProtocol{
    var view: NewNoteViewProtocol?
    
    var interactor: NewNoteInteractorProtocol?
    
    var router: NewNoteRouterProtocol?
    
    func addNewData(_ noteTitle: String, _ noteInfo: String) {
        let notes = NotesData(noteTitle: noteTitle, noteInfo: noteInfo)
       
        router?.goToNoteView(notes)
        
    }
    
    
}
