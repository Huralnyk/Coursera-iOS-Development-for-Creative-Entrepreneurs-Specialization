//
//  ChoreLogMO.m
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/7/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ChoreLogMO.h"
#import "ChoreMO.h"
#import "PersonMO.h"

@implementation ChoreLogMO

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@) (%@) (%@)", self.person_who_did_it.person_name, self.chore_done.chore_name, self.when];
}

@end
