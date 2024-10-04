//
//  NotesEntity.swift
//  My_Note_App
//
//  Created by Yashom on 23/09/24.
//

import Foundation

struct NotesData{
    var noteTitle: String
    var noteInfo: String
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
NoteApp is a comprehensive note-taking application designed for users who need an efficient and user-friendly way to manage their notes. The app allows you to easily add, update, and delete notes, providing a seamless experience for organizing your thoughts and ideas.

Key Features:
    Easy Note Management: Effortlessly add new notes, update existing ones, and delete notes you no longer need.
    Sliding Navigation Bar: A user-friendly sliding bar enhances usability and makes accessing different sections of the app a breeze.
    Secure Authentication: Robust login and sign-up authentication ensure that your notes remain private and secure.
    Core Data Storage: Notes are efficiently stored using Core Data, providing reliable data management and quick access.
    Flexible View Modes: Switch between list and grid views with a simple icon toggle, allowing you to choose the layout that best suits your needs.
How to Use NoteApp:
    Sign Up / Log In: Start by creating an account or logging in if you already have one. This ensures your notes are saved securely.
    Adding a Note:
    Tap the "+" icon or "Add Note" button to create a new note.
    Enter your text, add any relevant tags or categories, and save your note.
    Updating a Note:
    Select the note you want to edit from your list or grid view.
    Make your changes and tap "Save" to update it.
    Deleting a Note:
    Swipe left on the note you wish to remove or tap the delete icon while viewing the note.
    Confirm the deletion to remove it permanently.
    Changing Views:
    Use the view toggle icon to switch between list and grid layouts, depending on your preference for organizing notes.
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
