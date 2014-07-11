import Cocoa
import XCTest
import SwiftCoreDataRelationshipRepro

class SwiftCoreDataRelationshipReproTests: XCTestCase {
    func testSwiftToMany() {
        let moc = newMoc()
        
        // This works:
        NSManagedObject(
            entity: NSEntityDescription.entityForName("Person", inManagedObjectContext: moc),
            insertIntoManagedObjectContext: moc)
        
        XCTAssert(moc.save(nil), "");
    }
    
    func testSwiftToOne() {
        let moc = newMoc()
        
        // This works:
        XCTAssertNotNil(NSEntityDescription.entityForName("Person", inManagedObjectContext: moc));
        
        // This fails:
        XCTAssertNotNil(NSEntityDescription.entityForName("Pet", inManagedObjectContext: moc));
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
