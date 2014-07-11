import Cocoa
import XCTest
import SwiftCoreDataRelationshipRepro

let EXCERCISE_TO_ONE = true

class SwiftCoreDataRelationshipReproTests: XCTestCase {
    func testSwift() {
        let moc = newMoc()
        
        if EXCERCISE_TO_ONE {
            // This fails:
            NSManagedObject(
                entity: NSEntityDescription.entityForName("Pet", inManagedObjectContext: moc),
                insertIntoManagedObjectContext: moc)
        } else {
            // This works:
            NSManagedObject(
                entity: NSEntityDescription.entityForName("Person", inManagedObjectContext: moc),
                insertIntoManagedObjectContext: moc)
        }
    }
    
    func newMoc() -> (NSManagedObjectContext) {
        let momURL : NSURL = NSBundle.mainBundle().URLForResource("SwiftCoreDataRelationshipRepro", withExtension: "momd")
        let mom : NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: momURL)
        let psc : NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom);
        let ps : NSPersistentStore = psc.addPersistentStoreWithType(
            NSInMemoryStoreType,
            configuration: nil,
            URL: nil,
            options: nil,
            error: nil)
        let moc : NSManagedObjectContext = NSManagedObjectContext()
        moc.persistentStoreCoordinator = psc
        return moc
    }
}
