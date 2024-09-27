//
//  NotesRouter.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation
import UIKit

protocol NotesRouterProtocol{
    var entry: MyNotesViewController?{get }
    var presenter:NotesPresenterProtocol? { get set }
    static var routers:NotesRouterProtocol?{get set}
    
    static func startExecution() -> NotesRouterProtocol
    
    func goToDetail(note:NotesData)
    func goToNewNote()
    func backToNote(_ notes:NotesData)
}
class NotesRouter:NotesRouterProtocol{

    
    static var routers: NotesRouterProtocol?
    
    
    var entry: MyNotesViewController?
    var presenter:NotesPresenterProtocol?
    
    static func startExecution() -> NotesRouterProtocol {
        let router = NotesRouter()
        let presenter = NotesPresenter()
        let view = MyNotesViewController()
        let interactor = NotesInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.presenter = presenter
        router.entry = view
        self.routers = router
        
        return router
    }
    
    func goToDetail(note: NotesData) {
        let detailRouter = CompleteNoteRouter.noteDetail(note: note)
        guard let detailView = detailRouter.entry else {return}
        guard let viewController = self.entry else{return}
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func goToNewNote(){
        let newNote = NewNoteRouter.completeNewNote()
        guard let newView = newNote.entry else{return}
        let viewController = self.entry
        viewController?.navigationController?.pushViewController(newView, animated: true)
    }
    
    func backToNote(_ notes: NotesData){
        self.presenter?.interactor?.myNote = notes
        self.presenter?.viewDidLoad()
        print("back to note view")
        
    }
    
}
