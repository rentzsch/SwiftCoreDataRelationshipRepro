import Cocoa
import XCTest
import SwiftCoreDataRelationshipRepro

let USE_PERSON_CLASS = false

class SwiftCoreDataRelationshipReproTests: XCTestCase {
    func testExample() {
        let moc = newMoc()
        
        if USE_PERSON_CLASS {
            NSManagedObject(
                entity: NSEntityDescription.entityForName("Person", inManagedObjectContext: moc),
                insertIntoManagedObjectContext: moc)
            XCTAssert(moc.save(nil), "")
        } else {
            NSManagedObject(
                entity: NSEntityDescription.entityForName("Pet", inManagedObjectContext: moc),
                insertIntoManagedObjectContext: moc)
        }
        
        //
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
