//
//  TDMNavigationViewController.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "TDMNavigationViewController.h"

@interface TDMNavigationViewController ()

@end

@implementation TDMNavigationViewController

- (void)setMOC:(NSManagedObjectContext *)context {
    id<TDMHandlerMOC> child = (id<TDMHandlerMOC>)self.viewControllers[0];
    [child setMOC:context];
}

@end
