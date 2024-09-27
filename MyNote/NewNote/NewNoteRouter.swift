//
//  NewNoteRouter.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation

protocol NewNoteRouterProtocol{
    var entry:NewNoteViewController?{get set}
    static func completeNewNote() -> NewNoteRouterProtocol
    func goToNoteView(_ notes:NotesData)
        
}

class NewNoteRouter : NewNoteRouterProtocol{
    var entry: NewNoteViewController?
    
    static func completeNewNote() -> NewNoteRouterProtocol{
        let view = NewNoteViewController()
        let presenter = NewNotePresenter()
        let router = NewNoteRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        router.entry = view
        return router
    }
    
    func goToNoteView(_ notes:NotesData) {
        
        NotesRouter.routers?.backToNote(notes)
        
        let viewController = self.entry
        //viewController?.navigationController?.pushViewController(noteViewController, animated: true)
        viewController?.navigationController?.popViewController(animated: true)
        print("go to note view")
    }
    
}
