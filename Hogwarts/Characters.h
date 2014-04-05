//
//  Characters.h
//  Hogwarts
//
//  Created by Jian Yao Ang on 4/4/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Characters : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spells;
@property (nonatomic, retain) NSString * house;

@end
