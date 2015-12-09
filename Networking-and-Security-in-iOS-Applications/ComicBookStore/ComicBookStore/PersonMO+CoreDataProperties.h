//
//  PersonMO+CoreDataProperties.h
//  ComicBookStore
//
//  Created by Alexey Huralnyk on 12/9/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSSet<ComicBookMO *> *comic_books;

@end

@interface PersonMO (CoreDataGeneratedAccessors)

- (void)addComic_booksObject:(ComicBookMO *)value;
- (void)removeComic_booksObject:(ComicBookMO *)value;
- (void)addComic_books:(NSSet<ComicBookMO *> *)values;
- (void)removeComic_books:(NSSet<ComicBookMO *> *)values;

@end

NS_ASSUME_NONNULL_END
