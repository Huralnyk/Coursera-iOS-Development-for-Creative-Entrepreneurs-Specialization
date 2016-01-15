//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Alexey Huralnyk on 12/31/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

double metersToMiles(double meters) {
    return meters * 0.00062;
}

double metersToKilometers(double meters) {
    return meters * 0.001;
}

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *firstDestination;
@property (weak, nonatomic) IBOutlet UITextField *secondDestination;
@property (weak, nonatomic) IBOutlet UITextField *thirdDestination;
@property (weak, nonatomic) IBOutlet UITextField *fourthDestination;

@property (weak, nonatomic) IBOutlet UILabel *firstDistance;
@property (weak, nonatomic) IBOutlet UILabel *secondDistance;
@property (weak, nonatomic) IBOutlet UILabel *thirdDistance;
@property (weak, nonatomic) IBOutlet UILabel *fourthDistance;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSelector;

@property (nonatomic) DGDistanceRequest *request;

@end

@implementation ViewController

- (IBAction)calculateButtonTapped:(id)sender {
    
    self.calculateButton.enabled = NO;
    
    NSArray *destinations = @[self.firstDestination.text, self.secondDestination.text, self.thirdDestination.text, self.fourthDestination.text];
    NSString *source = self.startLocation.text;
    
    self.request = [[DGDistanceRequest alloc] initWithLocationDescriptions:destinations sourceDescription:source];
    

    __weak ViewController *weakSelf = self;
    
    self.request.callback = ^(NSArray *responses) {
        ViewController *strongSelf = weakSelf;
        if (!strongSelf) { return; }
        
        strongSelf.firstDistance.text = [strongSelf composeDestinationDescription:responses[0]];
        strongSelf.secondDistance.text = [strongSelf composeDestinationDescription:responses[1]];
        strongSelf.thirdDistance.text = [strongSelf composeDestinationDescription:responses[2]];
        strongSelf.fourthDistance.text = [strongSelf composeDestinationDescription:responses[3]];
        
        strongSelf.calculateButton.enabled = YES;
        strongSelf.request = nil;
    };
    
    [self.request start];
}

- (NSString *)composeDestinationDescription:(id)response {
    NSNull *badResult = [NSNull null];
    
    if (response != badResult) {
        double meters = [response doubleValue];
        
        if (self.unitSelector.selectedSegmentIndex == 0) {
            return [NSString stringWithFormat:@"%.2f m", meters];
        } else if (self.unitSelector.selectedSegmentIndex == 1) {
            return [NSString stringWithFormat:@"%.2f km", metersToKilometers(meters)];
        } else if (self.unitSelector.selectedSegmentIndex == 2) {
            return [NSString stringWithFormat:@"%.2f miles", metersToMiles(meters)];
        }
    }
    
    return @"?";
}

@end
