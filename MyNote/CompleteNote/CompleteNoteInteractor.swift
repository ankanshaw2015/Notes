//
//  CompleteNoteInteractor.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation
protocol CompleteNoteInteractorProtocol{
    var presenter : CompleteNotePresenterProtocol?{get set}
    var note : NotesData?{get set}
    
    func getNote()
}

class CompleteNoteInteractor:CompleteNoteInteractorProtocol{
    var presenter: CompleteNotePresenterProtocol?
    
    var note: NotesData?
    
    func getNote() {
        presenter?.updateData(note: note)
        print(note?.noteInfo ?? "no value found")
    }
    
    
}
