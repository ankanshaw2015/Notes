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
import CoreData
import UIKit

class CoreDataStack {
    static let shared = CoreDataStack()

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init() {
    }
    
}
