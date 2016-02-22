//
//  ToDoEntity+CoreDataProperties.h
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/22/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nonatomic) NSTimeInterval dueDate;
@property (nullable, nonatomic, retain) NSString *details;
@property (nonatomic) ToDoEntityPriority priority;
@property (nonatomic) BOOL done;

@end

NS_ASSUME_NONNULL_END
