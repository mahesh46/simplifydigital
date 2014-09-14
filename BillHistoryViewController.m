//
//  BillHistoryViewController.m
//  EBC
//
//  Created by mahesh lad on 05/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "BillHistoryViewController.h"

#import "BillHistoryTableViewController.h"

@interface BillHistoryViewController ()

@end

@implementation BillHistoryViewController
NSDate * startdate ;
NSDate * enddate;
NSDateComponents *components;
NSInteger days;

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
    
    _startdateoutlet.delegate = self;
    _enddateoutlet.delegate = self;
    
    [_startdateoutlet resignFirstResponder];
    [_enddateoutlet resignFirstResponder];
    [self.billhistorydatepicker setHidden:YES];
    
  
    [_billhistorydatepicker setDatePickerMode:UIDatePickerModeDate];
    startedit = false;
    endedit = false;
    
  self.startdateoutlet.inputView = _billhistorydatepicker ;
    self.enddateoutlet.inputView = _billhistorydatepicker ;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchbuttonaction:(id)sender {
    [_startdateoutlet resignFirstResponder];
    [_enddateoutlet resignFirstResponder];
    _startdateoutlet.text = @"";
    _enddateoutlet.text = @"";
    
    
}

- (IBAction)bhdatepickervaluechange:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:picker.date];
    //self.billdateoutlet.text = [NSString stringWithFormat:@"%@", dateString];
    
    
    NSDate  *  vardate = [dateFormatter dateFromString:dateString];
    
    if (startedit == true) {
       // [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       // NSString *dateString = [dateFormatter stringFromDate:picker.date];
        self.startdateoutlet.text = [NSString stringWithFormat:@"%@", dateString];
         startdate = vardate;
    }
    if (endedit ==true){
       // [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       // NSString *dateString = [dateFormatter stringFromDate:picker.date];
     self.enddateoutlet.text = [NSString stringWithFormat:@"%@", dateString];
        enddate = vardate;
    }
}

- (IBAction)Bhdatepickerbeginedit:(id)sender {
    [self.billhistorydatepicker setHidden:NO];

}

- (IBAction)startbeingedit:(id)sender {
    startedit = true;
   endedit = false;
     [self.billhistorydatepicker setHidden:NO];
}

- (IBAction)endbeginedit:(id)sender {
    endedit = true;
    startedit = false;
     [self.billhistorydatepicker setHidden:NO];
}

// background Touched routine
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_startdateoutlet resignFirstResponder];
    [_enddateoutlet resignFirstResponder];
    startedit = false;
    endedit = false;

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
    if ([[segue identifier] isEqualToString:@"showBillHistory"]){
        
       
        BillHistoryTableViewController * historytableviewcontroller  = [segue destinationViewController];
        
        NSString *startdateval  = [[NSString alloc] initWithFormat:@"%@",self.startdateoutlet.text];
        NSString *enddateval  = [[NSString alloc] initWithFormat:@"%@",self.enddateoutlet.text];
       
             historytableviewcontroller.datemodel = [[NSArray alloc] initWithObjects:startdateval, enddateval, nil];
        
    }


}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([_startdateoutlet.text isEqualToString:@""] || [_enddateoutlet.text isEqualToString:@""]) {
        UIAlertView * errorMessage = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"You must enter a valid date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
        
        return false;
    }
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: startdate toDate: enddate options: 0];
    days = [components day];

    if (days < 0) {
        UIAlertView * errorMessage = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"start date must be before enddate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];

        return false;
    }
    return true;
}
@end
