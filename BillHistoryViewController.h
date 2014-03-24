//
//  BillHistoryViewController.h
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillHistoryTableViewController.h"


@interface BillHistoryViewController : UIViewController <UITextFieldDelegate>
{
    bool startedit;
    bool endedit;
    
}
@property (weak, nonatomic) IBOutlet UITextField *startdateoutlet;
@property (weak, nonatomic) IBOutlet UITextField *enddateoutlet;
@property (weak, nonatomic) IBOutlet UIDatePicker *billhistorydatepicker;

- (IBAction)searchbuttonaction:(id)sender;
- (IBAction)bhdatepickervaluechange:(id)sender;
- (IBAction)Bhdatepickerbeginedit:(id)sender;
- (IBAction)startbeingedit:(id)sender;
- (IBAction)endbeginedit:(id)sender;

@end
