//
//  BillHistoryTableViewController.m
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "BillHistoryTableViewController.h"

#import "Entity.h"
#import "AppDelegate.h"


@interface BillHistoryTableViewController ()

@end

@implementation BillHistoryTableViewController


@synthesize managedObjectContext ;
//@synthesize tableView;  //local declaration of tableView hides instance variable
@synthesize tableView = _tableView;
@synthesize fetchedResultsController;


NSString *searchstartdate ;
NSString *searchenddate ;


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
     searchstartdate = [self.datemodel objectAtIndex:0];
    searchenddate = [self.datemodel objectAtIndex:1];

}

- (void)viewWillAppear {
    
    [self.tableView reloadData];
}

- (void)viewDidUnload {
    
    // Release any properties that are loaded in viewDidLoad or can be recreated lazily.
    self.fetchedResultsController = nil;
}


-(void)viewDidAppear:(BOOL)animated{
    //coredata
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
   
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Entity" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSError *error;
    
    
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
        
        [self.tableView reloadData];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source methods

/*
 The data source methods are handled primarily by the fetch results controller
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}




// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Entity *info = [fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    //  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:info.billdate];
    
    
    NSString * firstlabel = [NSString stringWithFormat:@"%@  Date:%@", info.supplier,dateString];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.textColor = [UIColor whiteColor];
     //cell.textLabel.font = [UIFont fontWithName:@"MuseoSlab-500" size:17.0];
    cell.textLabel.font = [UIFont fontWithName:@"MuseoSlab-500" size:20.0];
    cell.textLabel.text = firstlabel;
   // NSString = [info.amount stringValue];
  //  label.text = convertedString;
  
   //NSString * amount = [NSString stringWithFormat:@"%f", [NSDecimalNumber [info.amount]]];
 
    
    if([info.type isEqualToString:@"gas"]){
        cell.imageView.image = [UIImage imageNamed:@"gas.png"];
    }
    if([info.type isEqualToString:@"electric"]){
        cell.imageView.image = [UIImage imageNamed:@"electric.png"];
    }
    if([info.type isEqualToString:@"water"]){
        cell.imageView.image = [UIImage imageNamed:@"water.png"];
    }
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 10.0;

    
     cell.detailTextLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:15.0];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"Bill amount :%@", info.amount];
    
}



#pragma mark - Table view data source



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


-(void) loadrecords{
    //load sqlite billsDB
    //record =
    NSLog(@"tbl reloadData");
    [_tableView reloadData];
}

#pragma mark - Table view data source




#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Entity" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSLog(@"nsfetchresultsController 111");
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    
//   use nspredicate to select specific records e.g.
    //    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName like %@) AND (birthday > %@)", lastNameSearchString, birthdaySearchDate];
//
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate  *  startdate = [dateFormatter dateFromString:searchstartdate];
     NSDate  *  enddate = [dateFormatter dateFromString:searchenddate];
      NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(billdate > %@) AND (billdate < %@)", startdate, enddate];
  [fetchRequest setPredicate:predicate];
    NSLog(@"nsfetchresultsController 111.5");

    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSLog(@"nsfetchresultsController 112");
    
    
    
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //nil for cache name means no cache
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSLog(@"nsfetchresultsController 113");
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    // UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[_tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

//[NSFetchedResultsController deleteCacheWithName:nil];
- (void)applicationWillTerminate:(UIApplication *)application {
    //[NSFetchedResultsController deleteCacheNamed:@"Entity"];
    [NSFetchedResultsController deleteCacheWithName:nil];
    //etc
}


@end
