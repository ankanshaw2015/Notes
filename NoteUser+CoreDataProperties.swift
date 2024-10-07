//
//  NoteUser+CoreDataProperties.swift
//  MyNote
//
//  Created by Yashom on 04/10/24.
//
//

import Foundation
import CoreData


extension NoteUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteUser> {
        return NSFetchRequest<NoteUser>(entityName: "NoteUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension NoteUser : Identifiable {

}
