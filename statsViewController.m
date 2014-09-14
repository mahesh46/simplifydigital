//
//  statsViewController.m
//  EBC
//
//  Created by mahesh lad on 15/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "statsViewController.h"

#import "Entity.h"
#import "AppDelegate.h"


@interface statsViewController ()

@end

@implementation statsViewController

float  totalamount ;
float  totalgas;
float  totalelectric;
float  totalwater;
float  countgas;
float  countelectric;
float  countwater;
float  avggas;
float  avgelectric;
float  avgwater;

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
    //coredata
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    totalamount = 0.00;
    totalgas = 0.00;
    countgas = 0;
    avggas = 0.00;
    totalelectric = 0.00;
    countelectric = 0;
    avgelectric = 0.00;
    totalwater = 0.00;
    countwater = 0;
    avgwater = 0.00;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Entity" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    
     NSError *error;
    
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
      //
        NSLog(@"Supplier: %@", [info valueForKey:@"supplier"]);
        
               NSString *stringmyamount = [info valueForKey:@"amount"] ;
        if (stringmyamount == NULL){
            stringmyamount = @"0.00";
        }
    
        
        
        
        NSLog(@"Amount: %@", stringmyamount);
       
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
       float  sum = [stringmyamount floatValue];
        NSString *type = [info valueForKey:@"type"] ;
        if ([type isEqualToString:@"gas"]){
            totalgas = totalgas + sum;
            countgas = countgas + 1;
        }
        if ([type isEqualToString:@"electric"]){
            totalelectric = totalelectric + sum;
            countelectric = countelectric + 1;
        }
        if ([type isEqualToString:@"water"]){
            totalwater = totalwater + sum;
            countwater = countwater + 1;
        }
        NSLog(@"Amount: %f", sum);
        totalamount = totalamount + sum;
    }
    avggas = (totalgas / countgas);
    avgelectric = (totalelectric / countelectric);
    avgwater = (totalwater / countwater);
    _totalAmoutoutlet.text = [[NSString alloc] initWithFormat:@"£ %0.2f", totalamount];
    _avggasoutlet.text = [[NSString alloc] initWithFormat:@"£ %0.2f", avggas];
    _avgelectricoutlet.text = [[NSString alloc] initWithFormat:@"£ %0.2f", avgelectric];
    _avgwateroutlet.text = [[NSString alloc] initWithFormat:@"£ %0.2f", avgwater];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
