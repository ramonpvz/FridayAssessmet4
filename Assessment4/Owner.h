//
//  Owner.h
//  Assessment4
//
//  Created by GLBMXM0002 on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog;

@interface Owner : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dogs;
@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addDogsObject:(Dog *)value;
- (void)removeDogsObject:(Dog *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

@end
