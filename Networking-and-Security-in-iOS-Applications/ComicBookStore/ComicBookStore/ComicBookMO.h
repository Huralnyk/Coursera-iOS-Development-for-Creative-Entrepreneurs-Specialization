//
//  ComicBookMO.h
//  ComicBookStore
//
//  Created by Alexey Huralnyk on 12/9/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonMO;

NS_ASSUME_NONNULL_BEGIN

@interface ComicBookMO : NSManagedObject

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END

#import "ComicBookMO+CoreDataProperties.h"
