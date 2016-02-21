//
//  TDMHandlerToDoEntity.h
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity.h"

@protocol TDMHandlerToDoEntity <NSObject>

- (void)setToDoItem:(ToDoEntity *)item;

@end
