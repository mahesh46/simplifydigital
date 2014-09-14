//
//  statsViewController.h
//  EBC
//
//  Created by mahesh lad on 15/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface statsViewController : UIViewController<NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalAmoutoutlet;
@property (weak, nonatomic) IBOutlet UILabel *avggasoutlet;
@property (weak, nonatomic) IBOutlet UILabel *avgelectricoutlet;
@property (weak, nonatomic) IBOutlet UILabel *avgwateroutlet;

@end
