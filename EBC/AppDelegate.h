//
//  AppDelegate.h
//  EBC
//
//  Created by mahesh lad on 04/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
	//UIWindow *window;
	//UINavigationController *navigationController;
    
}


@property (strong, nonatomic) UIWindow *window;

//core data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UINavigationController *navigationController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
