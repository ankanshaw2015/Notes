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
   // var email:String? { get set }
    
    static func startExecution(email:String) -> NotesRouterProtocol

    func goToDetail(note:NoteInfo)
    func goToNewNote()
    func backToNote(_ notes:NotesData)
    func goToLogIn()
}
class NotesRouter:NotesRouterProtocol{
    
  //  var email:String?
    static var routers: NotesRouterProtocol?
    
    
    var entry: MyNotesViewController?
    var presenter:NotesPresenterProtocol?
    
    static func startExecution(email:String) -> NotesRouterProtocol {
        let router = NotesRouter()
        let presenter = NotesPresenter()
        let view = MyNotesViewController()
        let interactor = NotesInteractor()
        let slideBar = SlideMenuView()
        
        view.presenter = presenter
        view.slideMenu = slideBar
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        slideBar.present = presenter
        slideBar.email = email
        
        router.presenter = presenter
        router.entry = view
        self.routers = router
        
        return router
    }
    
   // func goToDetail(note: NotesData) {
    func goToDetail(note: NoteInfo){
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
        entry?.animation = true
        
    }
    func goToLogIn() {

        
        let router = LogInRouter.routing()
            
            let entryViewController = router.entry // This is your LogInView

            // Wrap the entryViewController in a navigation controller
        let navigationController = UINavigationController(rootViewController: entryViewController!)

            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                // Access the window safely
                if let window = sceneDelegate.window {
                    // Set the root view controller
                    window.rootViewController = navigationController

                    // Add a transition animation
                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                        window.rootViewController = navigationController
                    }, completion: nil)

                    window.makeKeyAndVisible()
                }
            }
            print("logout router")
    }
    
    
}
