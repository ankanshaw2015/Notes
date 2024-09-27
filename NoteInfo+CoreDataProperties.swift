//
//  NoteInfo+CoreDataProperties.swift
//  MyNote
//
//  Created by Yashom on 26/09/24.
//
//

import Foundation
import CoreData


extension NoteInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteInfo> {
        return NSFetchRequest<NoteInfo>(entityName: "NoteInfo")
    }

    @NSManaged public var noteTitle: String?
    @NSManaged public var noteData: String?

}

extension NoteInfo : Identifiable {

}
