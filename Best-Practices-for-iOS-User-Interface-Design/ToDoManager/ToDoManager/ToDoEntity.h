//
//  ToDoEntity.h
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(int16_t, ToDoEntityPriority) {
    ToDoEntityPriorityLow,
    ToDoEntityPriorityMedium,
    ToDoEntityPriorityHigh
};

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "ToDoEntity+CoreDataProperties.h"
