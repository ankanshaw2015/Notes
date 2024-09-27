//
//  CompleteNoteRouter.swift
//  My_Note_App
//
//  Created by Yashom on 24/09/24.
//

import Foundation
protocol CompleteNoteRouterProtocol{
    var entry:CompleteNoteViewController? { get set }
    static func noteDetail(note:NotesData) -> CompleteNoteRouterProtocol
}

class CompleteNoteRouter : CompleteNoteRouterProtocol{
    var entry: CompleteNoteViewController?
    
    static func noteDetail(note: NotesData) -> CompleteNoteRouterProtocol {
        let router = CompleteNoteRouter()
        
        let view = CompleteNoteViewController()
        let presenter = CompleteNotePresenter()
        let interactor = CompleteNoteInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.note = note
        
        router.entry = view
        return router
    }
    
    
}
