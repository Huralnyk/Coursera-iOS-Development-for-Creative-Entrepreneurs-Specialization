//
//  ChoreMO.h
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/7/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChoreLogMO;

NS_ASSUME_NONNULL_BEGIN

@interface ChoreMO : NSManagedObject

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END

#import "ChoreMO+CoreDataProperties.h"
