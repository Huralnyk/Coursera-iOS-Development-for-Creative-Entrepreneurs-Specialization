//
//  ToDoEntity+CoreDataProperties.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/22/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity+CoreDataProperties.h"

@implementation ToDoEntity (CoreDataProperties)

@dynamic title;
@dynamic dueDate;
@dynamic details;
@dynamic priority;
@dynamic done;

@end
