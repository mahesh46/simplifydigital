//
//  Entity.h
//  EBC
//
//  Created by mahesh lad on 07/03/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * supplier;

@property  (nonatomic, strong) NSDate * billdate;
@property (nonatomic) NSNumber* amount;
@end
