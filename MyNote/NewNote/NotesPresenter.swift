//
//  NotesPresenter.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation


//var context = CoreDataStack.shared.context

protocol NotesPresenterProtocol{
    
    var view: NotesViewProtocol?{get set}
    var interactor: NotesInteractorProtocol?{get set}
    var router: NotesRouterProtocol?{get set}
    
    func viewDidLoad()
    func NotesData(result: [NoteInfo])
    func detailNote(_ note: NoteInfo)
    func addNewNote()
}

class NotesPresenter: NotesPresenterProtocol{

    var view: NotesViewProtocol?
    var interactor: NotesInteractorProtocol?
    
    var router: NotesRouterProtocol?
    
    func viewDidLoad() {
        let user = Users.shared

        interactor?.getNoteData(id: user)
        
        //print("accept", user.userNotes![0].noteInfo)
    }
    
    func NotesData(result: [NoteInfo]) {
        
        if result.count != 0{
            view?.update(with: result)
                    }
        else{
            print("error")
        }
    }
    
    func detailNote(_ note: NoteInfo) {
        let title:String = note.noteTitle!
        let note:String = note.noteData!
        let data = MyNote.NotesData(noteTitle: title, noteInfo: note)
        router?.goToDetail(note: data)
    }
    
    func addNewNote() {
        router?.goToNewNote()
    }
    
}
