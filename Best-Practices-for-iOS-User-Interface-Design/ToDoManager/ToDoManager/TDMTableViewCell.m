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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation TDMTableViewCell

- (void)setToDoItem:(ToDoEntity *)item {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    self.item = item;
    self.titleLabel.text = item.title;
    self.dateLabel.text = [formatter stringFromDate:item.dueDate];
}

@end
