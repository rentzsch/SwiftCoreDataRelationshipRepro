[Related Stackoverflow Question](http://stackoverflow.com/q/24688969/5260)

Steps to Reproduce
------------------

1. Open project in Xcode 6b3 or 6b4.
2. Cmd-U (Product > Test)

Expected Results
----------------

All tests pass (instantiating an NSManagedObject with a to-one relationship using Swift works).

Actual Results
--------------

The Swift to-one test (`testSwiftToOne`) fails with an exception:

	file:///%3Cunknown%3E: test failure: -[SwiftCoreDataRelationshipReproTests testSwiftToOne()] failed: failed: caught "NSInvalidArgumentException", "An NSManagedObject of class 'NSManagedObject' must have a valid NSEntityDescription."
	(
		0   CoreFoundation                      0x00007fff8dd6525c __exceptionPreprocess + 172
		1   libobjc.A.dylib                     0x00007fff84ce5e75 objc_exception_throw + 43
		2   CoreData                            0x00007fff8765dd16 -[NSManagedObject initWithEntity:insertIntoManagedObjectContext:] + 550
		3   SwiftCoreDataRelationshipReproTests 0x0000000100394d4a _TTOFCSo15NSManagedObjectcfMS_FT6entityGSQCSo19NSEntityDescription_30insertIntoManagedObjectContextGSQCSo22NSManagedObjectContext__S_ + 42
		4   SwiftCoreDataRelationshipReproTests 0x00000001003946bd _TFCSo15NSManagedObjectCfMS_FT6entityGSQCSo19NSEntityDescription_30insertIntoManagedObjectContextGSQCSo22NSManagedObjectContext__S_ + 93
		5   SwiftCoreDataRelationshipReproTests 0x0000000100393450 _TFC35SwiftCoreDataRelationshipReproTests35SwiftCoreDataRelationshipReproTests14testSwiftToOnefS0_FT_T_ + 816
		6   SwiftCoreDataRelationshipReproTests 0x00000001003934c2 _TToFC35SwiftCoreDataRelationshipReproTests35SwiftCoreDataRelationshipReproTests14testSwiftToOnefS0_FT_T_ + 34
		7   CoreFoundation                      0x00007fff8dc50a5c __invoking___ + 140
		8   CoreFoundation                      0x00007fff8dc508c4 -[NSInvocation invoke] + 308
		9   XCTest                              0x00000001003b023a -[XCTestCase invokeTest] + 253
		10  XCTest                              0x00000001003b03ac -[XCTestCase performTest:] + 142
		11  XCTest                              0x00000001003b8ad0 -[XCTest run] + 257
		12  XCTest                              0x00000001003af68b -[XCTestSuite performTest:] + 379
		13  XCTest                              0x00000001003b8ad0 -[XCTest run] + 257
		14  XCTest                              0x00000001003af68b -[XCTestSuite performTest:] + 379
		15  XCTest                              0x00000001003b8ad0 -[XCTest run] + 257
		16  XCTest                              0x00000001003af68b -[XCTestSuite performTest:] + 379
		17  XCTest                              0x00000001003b8ad0 -[XCTest run] + 257
		18  XCTest                              0x00000001003acc8f __25-[XCTestDriver _runSuite]_block_invoke + 56
		19  XCTest                              0x00000001003b773d -[XCTestObservationCenter _observeTestExecutionForBlock:] + 162
		20  XCTest                              0x00000001003acbc8 -[XCTestDriver _runSuite] + 269
		21  XCTest                              0x00000001003ad34a -[XCTestDriver _checkForTestManager] + 551
		22  XCTest                              0x00000001003bb879 +[XCTestProbe runTests:] + 175
		23  Foundation                          0x00007fff8e0aacb7 __NSFireDelayedPerform + 333
		24  CoreFoundation                      0x00007fff8dccc494 __CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
		25  CoreFoundation                      0x00007fff8dccbfcf __CFRunLoopDoTimer + 1151
		26  CoreFoundation                      0x00007fff8dd3d5aa __CFRunLoopDoTimers + 298
		27  CoreFoundation                      0x00007fff8dc87755 __CFRunLoopRun + 1525
		28  CoreFoundation                      0x00007fff8dc86f25 CFRunLoopRunSpecific + 309
		29  HIToolbox                           0x00007fff8e566a0d RunCurrentEventLoopInMode + 226
		30  HIToolbox                           0x00007fff8e566685 ReceiveNextEventCommon + 173
		31  HIToolbox                           0x00007fff8e5665bc _BlockUntilNextEventMatchingListInModeWithFilter + 65
		32  AppKit                              0x00007fff8538e26e _DPSNextEvent + 1434
		33  AppKit                              0x00007fff8538d8bb -[NSApplication nextEventMatchingMask:untilDate:inMode:dequeue:] + 122
		34  AppKit                              0x00007fff853819bc -[NSApplication run] + 553
		35  AppKit                              0x00007fff8536c7a3 NSApplicationMain + 940
		36  SwiftCoreDataRelationshipRepro      0x000000010000ad55 top_level_code + 37
		37  SwiftCoreDataRelationshipRepro      0x000000010000ad8a main + 42
		38  libdyld.dylib                       0x00007fff861115fd start + 1
	)

Notes
-----

- Instantiating an entity via Swift with a to-many works (the `testSwiftToMany`).

- The more-complicated Obj-C test (`testObjcToOneAndToMany`) passes.
