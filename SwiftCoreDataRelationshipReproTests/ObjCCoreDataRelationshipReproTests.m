#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@interface ObjCCoreDataRelationshipReproTests : XCTestCase
@end

@implementation ObjCCoreDataRelationshipReproTests

- (void)testObjcToOneAndToMany {
    NSManagedObjectContext *moc = [self newMoc];
    
    // All of this works:
    NSManagedObject *person = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc]
                                       insertIntoManagedObjectContext:moc];
    [person setValue:@"Fred Flintstone" forKey:@"name"];
    
    //
    NSManagedObject *dino = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Pet" inManagedObjectContext:moc]
                                       insertIntoManagedObjectContext:moc];
    [dino setValue:@"Dino" forKey:@"name"];
    [dino setValue:person forKey:@"owner"];
    
    //
    NSManagedObject *babypuss = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Pet" inManagedObjectContext:moc]
                                       insertIntoManagedObjectContext:moc];
    [dino setValue:@"Baby Puss" forKey:@"name"];
    [babypuss setValue:person forKey:@"owner"];
    
    //
    XCTAssert([moc save:nil], @"");
}

- (NSManagedObjectContext*)newMoc {
    NSManagedObjectContext *result;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SwiftCoreDataRelationshipRepro" withExtension:@"momd"];
    assert(modelURL);
    
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    assert(model);
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    assert(persistentStoreCoordinator);
    
    NSError *inMemoryStoreError = nil;
    NSPersistentStore *persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                                                  configuration:nil
                                                                                            URL:nil
                                                                                        options:nil
                                                                                          error:&inMemoryStoreError];
    
    assert(persistentStore);
    assert(!inMemoryStoreError);
    
    result = [[NSManagedObjectContext alloc] init];
    [result setPersistentStoreCoordinator:persistentStoreCoordinator];
    assert(result);
    
    return result;
}

@end
