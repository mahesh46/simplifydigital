//
//  UserProfileViewController.h
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *yourNameoutlet;
@property (weak, nonatomic) IBOutlet UITextField *gasSupplieroutlet;
@property (weak, nonatomic) IBOutlet UITextField *electricSupplieroutlet;
@property (weak, nonatomic) IBOutlet UITextField *waterSupplieroutlet;
- (IBAction)saveProfilerecords:(id)sender;

@end
