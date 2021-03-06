import Cocoa
import XCTest
import SwiftCoreDataRelationshipRepro

extension NSEntityDescription {
    class func entityForName_workaround(entityName: String!, inManagedObjectContext context: NSManagedObjectContext!) -> NSEntityDescription! {
        let entities = context.persistentStoreCoordinator.managedObjectModel.entitiesByName;
        let keys = Array(entities.keys)
        var result : NSEntityDescription?
        for (key, value) in entities {
            if key == entityName {
                result = value as? NSEntityDescription
            }
        }
        return result
    }
}

class SwiftCoreDataRelationshipReproTests: XCTestCase {
    func testSwiftToMany() {
        let moc = newMoc()
        
        // This works:
        NSManagedObject(
            entity: NSEntityDescription.entityForName("Person", inManagedObjectContext:moc),
            insertIntoManagedObjectContext: moc)
        
        XCTAssert(moc.save(nil), "");
    }
    
    func testSwiftToOneNormal() {
        let moc = newMoc()
        
        // This works:
        XCTAssertNotNil(NSEntityDescription.entityForName("Person", inManagedObjectContext:moc));

        // This fails on 10.9.3 and 10.9.4 but works on 10.10:
        XCTAssertNotNil(NSEntityDescription.entityForName("Pet", inManagedObjectContext:moc));
    }
    
    func testSwiftToOneWithDirectWorkaround() {
        let moc = newMoc()
        
        // This works:
        XCTAssertNotNil(NSEntityDescription.entityForName("Person", inManagedObjectContext:moc));

        // This works on 10.9.3 and 10.10:
        let entities = moc.persistentStoreCoordinator.managedObjectModel.entitiesByName;
        let keys = Array(entities.keys)
        var petDescription : NSEntityDescription?
        for (key, value) in entities {
            if key == "Pet" {
                petDescription = value as? NSEntityDescription
            }
        }
        XCTAssertNotNil(petDescription);
    }
    
    func testSwiftToOneWithExtensionWorkaround() {
        let moc = newMoc()
        
        // This works:
        XCTAssertNotNil(NSEntityDescription.entityForName_workaround("Person", inManagedObjectContext:moc));

        // This works on 10.9.3 and 10.10:
        XCTAssertNotNil(NSEntityDescription.entityForName_workaround("Pet", inManagedObjectContext:moc));
    }
    
    func testSwiftToOneAndToMany() {
        // This fails on 10.9.3 and 10.9.4 but works on 10.10:
        
        let moc = newMoc()
        
        let person : NSManagedObject = NSManagedObject(
            entity: NSEntityDescription.entityForName_workaround("Person", inManagedObjectContext:moc),
            insertIntoManagedObjectContext: moc)
        person.setValue("Fred Flintstone", forKey:"name")
        
        //
        let petEntityDesc = NSEntityDescription.entityForName_workaround("Pet", inManagedObjectContext:moc)
        
        let dino : NSManagedObject = NSManagedObject(
            entity:petEntityDesc,
            insertIntoManagedObjectContext:moc)
        dino.setValue("Dino", forKey:"name")
        dino.setValue(person, forKey:"owner")
        
        let babypuss : NSManagedObject = NSManagedObject(
            entity:petEntityDesc,
            insertIntoManagedObjectContext:moc)
        dino.setValue("Baby Puss", forKey:"name")
        dino.setValue(person, forKey:"owner")
        
        XCTAssert(moc.save(nil), "");
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
