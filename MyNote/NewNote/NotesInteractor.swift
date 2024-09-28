//
//  NotesInteractor.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation
import UIKit


protocol NotesInteractorProtocol{
    var presenter : NotesPresenterProtocol? {get set}
    var myNote:NotesData?{get set}
    
    func getNoteData(id:Users)
    func deleteNote(note:NoteInfo)
    
    
}

class NotesInteractor: NotesInteractorProtocol{
   
    
    var myNote: NotesData?
    
    var presenter: NotesPresenterProtocol?
    
    let context = CoreDataStack.shared.context
    
    func getNoteData(id:Users) {
        
        if myNote?.noteTitle != nil{
            //            let note = NotesInfo(noteTitle: myNote!.noteTitle, noteInfo: myNote!.noteInfo)
            //
            //            id.userNotes.append(note)
            let note = NoteInfo(context: self.context)
            note.noteTitle = myNote?.noteTitle
            note.noteData = myNote?.noteInfo
            
            do{
                try self.context.save()
            }catch{
                
            }
            let items = fetchData()
            self.presenter?.NotesData(result: items)
            // print("success1", id.userNotes[0].noteInfo)
            
            
        }
        
        else{
                data()
            
        }
    }
    
    func fetchData() ->[NoteInfo]{
        var items = [NoteInfo]()
        let data = NoteInfo.fetchRequest()
        do{
            items = try context.fetch(data)
        }
        catch{
            
        }
        return items
    }
    
    func deleteNote(note: NoteInfo) {
        context.delete(note)
        do{
            try self.context.save()
        }
        catch{
            
        }
        data()
    }
    
    func data(){
        let data = fetchData()
        if data.count != 0{
            self.presenter?.NotesData(result: data)
        }
        else{
            self.presenter?.NotesData(result: data)
        }
    }
    
}
