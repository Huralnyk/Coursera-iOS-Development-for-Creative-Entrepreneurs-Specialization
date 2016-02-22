//
//  TDMTableViewCell.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "TDMTableViewCell.h"

@interface TDMTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UIImageView *doneView;
@end

@implementation TDMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priorityView.layer.cornerRadius = self.priorityView.frame.size.width / 2.0;
}

- (void)setToDoItem:(ToDoEntity *)item {
    self.item = item;
    self.titleLabel.text = item.title;
    self.priorityView.backgroundColor = [self colorForPriority:item.priority];
    self.doneView.image = item.done ? [UIImage imageNamed:@"checkbox"] : nil;
}

- (UIColor *)colorForPriority:(ToDoEntityPriority)priority {
    switch (priority) {
        case ToDoEntityPriorityLow:
            return [UIColor colorWithRed:66.0/255.0 green:171.0/255.0 blue:234.0/255.0 alpha:1];
            
        case ToDoEntityPriorityMedium:
            return [UIColor colorWithRed:253.0/255.0 green:210.0/255.0 blue:25.0/255.0 alpha:1];
            
        case ToDoEntityPriorityHigh:
            return [UIColor colorWithRed:255.0/255.0 green:88.0/255.0 blue:87.0/255.0 alpha:1];
    }
}

- (void)prepareForReuse {
    self.titleLabel.text = nil;
    self.priorityView.backgroundColor = [UIColor clearColor];
    self.doneView.image = nil;
}

@end
