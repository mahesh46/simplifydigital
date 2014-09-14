//
//  BillHistoryTableViewController.h
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillHistoryViewController.h"


#import <CoreData/CoreData.h>

//#import "DetailViewController.h"

@interface BillHistoryTableViewController :UIViewController <NSFetchedResultsControllerDelegate>{
  
    NSMutableArray *record;
   }
@property (strong, nonatomic) NSArray *datemodel ;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *BillRecordsInfos;

@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) NSString *databasePath;

//-----core data------need line below
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;




@end
