//
//  BillEntryViewController.h
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <sqlite3.h>
#import "AppDelegate.h"


@interface BillEntryViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *supplieroutlet;
@property (weak, nonatomic) IBOutlet UITextField *billdateoutlet;
@property (weak, nonatomic) IBOutlet UITextField *billamountoutlet;
@property (strong, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) NSString *billYourName;
@property (strong, nonatomic) NSString *billType;
@property (strong, nonatomic) NSString *billDate;
@property (strong, nonatomic) NSString *billSupplier;
@property (strong, nonatomic) NSString *billAmount;


@property (strong, nonatomic) NSString *databasePath;
//@property (nonatomic) sqlite3 *BillsDB;

@property (weak, nonatomic) IBOutlet UIDatePicker *datepickeroutlet;

//-----core data------need line below
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;


- (IBAction)supplierpickedaction:(id)sender;

- (IBAction)datepickerchanged:(id)sender;

- (IBAction)saveBillaction:(id)sender;
- (IBAction)dateofbill_beginedit:(id)sender;

@end
