//
//  ViewController.m
//  UnitConverter
//
//  Created by Alexey Huralnyk on 12/17/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"


double metersToFeet(double meters) {
    return meters * 3.28084;
}

double metersToYards(double meters) {
    return meters * 1.09361;
}

double metersToMiles(double meters) {
    return meters * 0.00062;
}


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switcher;
@property (weak, nonatomic) IBOutlet UILabel *output;

@end



@implementation ViewController

- (IBAction)updateTapped:(id)sender {
    NSMutableString *buffer = [[NSMutableString alloc] init];
    
    double meters = [self.input.text doubleValue];
    
    if (self.switcher.selectedSegmentIndex == 0) {
        double feet = metersToFeet(meters);
        [buffer appendFormat:@"%4f meters is %.4f feet", meters, feet];
    } else if (self.switcher.selectedSegmentIndex == 1) {
        double yards = metersToYards(meters);
        [buffer appendFormat:@"%4f meters is %.4f yards", meters, yards];
    } else {
        double miles = metersToMiles(meters);
        [buffer appendFormat:@"%4f meters is %.4f miles", meters, miles];
    }
    
    self.output.text = buffer;
}


@end
