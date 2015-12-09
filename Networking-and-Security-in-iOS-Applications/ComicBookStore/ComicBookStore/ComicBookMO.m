//
//  ComicBookMO.m
//  ComicBookStore
//
//  Created by Alexey Huralnyk on 12/9/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ComicBookMO.h"
#import "PersonMO.h"

@implementation ComicBookMO

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [%@][%@]", self.title, self.publisher, self.genre];
}

@end
