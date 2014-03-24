//
//  BillEntryViewController.m
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "BillEntryViewController.h"
#import "Entity.h"


@interface BillEntryViewController ()

@end
//NSString * billsupplier ;
//NSString * billtype;
NSDate *_date;


@implementation BillEntryViewController


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
    //set background
   // UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg.png"]];
   // [self.view addSubview:backgroundView];
    
	// Do any additional setup after loading the view.
  
    //set up defaults
     _billYourName = [[NSUserDefaults standardUserDefaults] stringForKey:@"yourName"];
    _billAmount = @"";
    _billType = @"gas";
    
   // billDate = @"today";  //get current date from code below
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    
     [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _billDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:[NSDate date]]];
    
    //
        _billdateoutlet.delegate = self;
    
       [self.datepickeroutlet setHidden:YES];
    
  
    [_datepickeroutlet setDatePickerMode:UIDatePickerModeDate];
    
    self.billdateoutlet.inputView = _datepickeroutlet ;
    
    
    
  }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// background Touched routine
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_billamountoutlet resignFirstResponder];
     [_billdateoutlet resignFirstResponder];
   _status.text = @"";
}

-(void) viewDidUnload
{
   // self.yourNameoutlet = nil;
    
}
- (IBAction)supplierpickedaction:(id)sender {
   
    switch (self.supplieroutlet.selectedSegmentIndex) {
        case 0:
            _billType = @"gas";
            break;
        case 1:
            
            _billType = @"electric";
            break;
        case 2:
            
            _billType = @"water";
            break;
        
        default:
            break;
    }

}

- (IBAction)datepickerchanged:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *dateString = [dateFormatter stringFromDate:picker.date];
    self.billdateoutlet.text = [NSString stringWithFormat:@"%@", dateString];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    dateString = [dateFormatter stringFromDate:picker.date];
   _date = [dateFormatter dateFromString:dateString];
    
    _billDate = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)saveBillaction:(id)sender {

    
    if ([_billType isEqualToString:@"gas"]){
    _billSupplier = [[NSUserDefaults standardUserDefaults] stringForKey:@"gasSupplier"];
    }
    
    if ([_billType isEqualToString:@"electric"]){
        _billSupplier = [[NSUserDefaults standardUserDefaults] stringForKey:@"electricSupplier"];
    }

    if ([_billType isEqualToString: @"water"]){
        _billSupplier = [[NSUserDefaults standardUserDefaults] stringForKey:@"waterSupplier"];
    }
    
   _billDate = [NSString stringWithFormat:@"%@",_billdateoutlet.text];
    _billAmount = [NSString  stringWithFormat:@"%@",_billamountoutlet.text];
    
    if ([_billDate  isEqual: @""] || [_billAmount isEqual:  @""]) {
        
        UIAlertView * errorMessage = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"You must enter a date and an amount" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
        return;
    }

    // Add records into core data file
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSManagedObject *tracksInfo = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Entity"
                                   inManagedObjectContext:context];
    
    //
    
   [tracksInfo setValue:_billYourName forKey:@"name"];
    [tracksInfo setValue:_billType forKey:@"type"];
    [tracksInfo setValue:_billSupplier forKey:@"supplier"];
    //
  
    [tracksInfo setValue:_date forKey:@"billdate"];

    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_billAmount];
    
    [tracksInfo setValue: myNumber forKey:@"amount"];

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        
        UIAlertView * SavedMessage = [[UIAlertView alloc] initWithTitle:@"Saved !" message:@"record saved successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [SavedMessage show];
        _billdateoutlet.text = @"";
        _billamountoutlet.text = @"";
    }
    //-----------
}

- (IBAction)dateofbill_beginedit:(id)sender {
    [self.datepickeroutlet setHidden:NO];

}
@end
