import Foundation
import CoreData

/**
    Enum for Event Entity member fields
*/
enum MovieAttributes: String {
    case
    eventId    = "eventId",
    title      = "title",
    date       = "date",
    country    = "country",
    actors  = "actors",
    longDescription = "longDescription",
    production = "production"

    static let getAll = [
        eventId,
        title,
        date,
        country,
        longDescription,
        production,
        actors
    ]
}

@objc(Event)

/**
    The Core Data Model: Event
*/
class Event: NSManagedObject {
    @NSManaged var actors: AnyObject
    @NSManaged var country: String
    @NSManaged var eventId: String
    @NSManaged var date: Date
    @NSManaged var title: String
    @NSManaged var longDescription: String
    @NSManaged var production: String
}
