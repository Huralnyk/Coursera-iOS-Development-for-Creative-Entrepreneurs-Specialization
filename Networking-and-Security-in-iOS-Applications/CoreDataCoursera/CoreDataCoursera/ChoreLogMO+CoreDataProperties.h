//
//  ChoreLogMO+CoreDataProperties.h
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/7/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ChoreLogMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoreLogMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *when;
@property (nullable, nonatomic, retain) ChoreMO *chore_done;
@property (nullable, nonatomic, retain) PersonMO *person_who_did_it;

@end

NS_ASSUME_NONNULL_END
