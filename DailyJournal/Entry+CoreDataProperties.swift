//
//  Entry+CoreDataProperties.swift
//  DailyJournal
//
//  Created by Anil Can on 15.04.2021.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Entry : Identifiable {

}
