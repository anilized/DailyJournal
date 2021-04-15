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
    
    // MARK: - Date things done with date formatter
    
    func month() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let dateToBeFormatted = date {
            let month = dateFormatter.string(from: dateToBeFormatted)
            return month.uppercased()
        }
        return ""
    }
    
    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        if let dateToBeFormatted = date {
            let day = dateFormatter.string(from: dateToBeFormatted)
            return day
        }
        return ""
    }

}
