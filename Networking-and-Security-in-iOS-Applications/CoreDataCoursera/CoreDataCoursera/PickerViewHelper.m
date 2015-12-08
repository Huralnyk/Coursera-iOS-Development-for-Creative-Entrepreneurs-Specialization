//
//  PickerViewHelper.m
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/8/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "PickerViewHelper.h"

@interface PickerViewHelper ()

@property (nonatomic) NSMutableArray *pickerData;

@end

@implementation PickerViewHelper

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.pickerData = [NSMutableArray arrayWithArray:@[]];
    }
    
    return self;
}

- (void)setArray:(NSArray *)incoming {
    self.pickerData = [NSMutableArray arrayWithArray:incoming];
}

- (void)addItemToArray:(NSObject *)thing {
    [self.pickerData addObject:thing];
}

- (NSObject *)getItemFromArray:(NSUInteger)index {
    return [self.pickerData objectAtIndex:index];
}



#pragma mark - UI Picker View Data Source & Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.pickerData objectAtIndex:row] description];
}

@end
