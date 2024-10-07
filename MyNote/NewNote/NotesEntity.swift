//
//  NotesEntity.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation

struct NotesData{
    var noteTitle: String
   // var noteInfo: String
    var noteData:String
}

class Users{
    static let shared = Users()
    private init() {}
    
//    var userId:Int?
//    var userName:String?
//    var userEmail:String?
//    var userPassword:String?
 //   var userNotes:[NotesInfo] = [NotesInfo(noteTitle: "aryan", noteInfo: "ankan")]
}

struct constant{
    let texts = """
About My Notes

        Developer: Ankan Shaw

        My Notes is a powerful and intuitive note-taking application designed to help you capture and organize your thoughts seamlessly. Built using UIKit with a programmatic UI approach, this app ensures a smooth and responsive user experience.

        Key Features:
        - Effortless Note Creation: Add notes quickly with a clear title and detailed description.
        - Flexible Editing Options: Edit or delete notes with ease, keeping your information up-to-date.
        - Dynamic Viewing: Switch between List and Grid views to find your notes in the format that suits you best.
        - User-Centric Design: Designed with a focus on simplicity and usability, making note-taking a breeze.

        Architecture:
        My Notes is built using the VIPER architecture, promoting a clear separation of concerns. This architecture enhances scalability and maintainability, ensuring that the app remains robust and efficient as it evolves.

        Whether you’re a student, professional, or anyone in between, My Notes is your go-to solution for managing notes effortlessly.

        Thank you for choosing My Notes! We hope it enhances your productivity and creativity.
"""
}

import CoreData
import UIKit

class CoreDataStack {
    static let shared = CoreDataStack()

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init() {
    }
    
}
