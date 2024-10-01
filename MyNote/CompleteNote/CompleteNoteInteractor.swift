//
//  CompleteNoteInteractor.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation
protocol CompleteNoteInteractorProtocol{
    var presenter : CompleteNotePresenterProtocol?{get set}
    var note : NoteInfo?{get set}
    
    func addEditedText()
    func getNote()
}

class CompleteNoteInteractor:CompleteNoteInteractorProtocol{
   
    let context = CoreDataStack.shared.context
    
    var presenter: CompleteNotePresenterProtocol?
    
    var note: NoteInfo?
    
//    func getNote() {
//        presenter?.updateData(note: note)
//        print(note?.noteInfo ?? "no value found")
//    }
    func getNote() {
        presenter?.updateData(note: note)
    }
    
    func addEditedText() {
        do{
            try self.context.save()
        }catch{
            
        }
    }
    
}
