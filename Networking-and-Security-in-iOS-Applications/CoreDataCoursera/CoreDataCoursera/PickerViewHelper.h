//
//  PickerViewHelper.h
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/8/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewHelper : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setArray:(NSArray *)incoming;
- (void)addItemToArray:(NSObject *)thing;
- (NSObject *)getItemFromArray:(NSUInteger)index;

@end
