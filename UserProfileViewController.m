//
//  UserProfileViewController.m
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    
    // get user defaults
    _yourNameoutlet.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"yourName"];
    _gasSupplieroutlet.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"gasSupplier"];

    _electricSupplieroutlet.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"electricSupplier"];
    _waterSupplieroutlet.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"waterSupplier"];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveProfilerecords:(id)sender {
    
  
        //save user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
// NSString *valueToSave = @"someValue";
    
    [defaults setObject:_yourNameoutlet.text forKey:@"yourName"];
    [defaults setObject:_gasSupplieroutlet.text forKey:@"gasSupplier"];
    [defaults setObject:_electricSupplieroutlet.text forKey:@"electricSupplier"];
     [defaults setObject:_waterSupplieroutlet.text forKey:@"waterSupplier"];
    
//    NSString *valueToSave = @"someValue";
//    [[NSUserDefaults standardUserDefaults]
//     setObject:valueToSave forKey:@"preferenceName"];
//    to get it back later
//    
//    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
//                            stringForKey:@"preferenceName"];
//    
    
}

// background Touched routine
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_yourNameoutlet resignFirstResponder];
    [_gasSupplieroutlet resignFirstResponder];
    [_electricSupplieroutlet resignFirstResponder];
    [_waterSupplieroutlet resignFirstResponder];
}

-(void) viewDidUnload
{
    self.yourNameoutlet = nil;
    self.gasSupplieroutlet = nil;
    self.electricSupplieroutlet = nil;
    self.waterSupplieroutlet = nil;
    
}

@end
