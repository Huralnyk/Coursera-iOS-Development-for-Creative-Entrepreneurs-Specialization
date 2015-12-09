//
//  ComicBookMO+CoreDataProperties.h
//  ComicBookStore
//
//  Created by Alexey Huralnyk on 12/9/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ComicBookMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComicBookMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *publisher;
@property (nullable, nonatomic, retain) NSString *genre;
@property (nullable, nonatomic, retain) NSSet<PersonMO *> *authors;

@end

@interface ComicBookMO (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(PersonMO *)value;
- (void)removeAuthorsObject:(PersonMO *)value;
- (void)addAuthors:(NSSet<PersonMO *> *)values;
- (void)removeAuthors:(NSSet<PersonMO *> *)values;

@end

NS_ASSUME_NONNULL_END
