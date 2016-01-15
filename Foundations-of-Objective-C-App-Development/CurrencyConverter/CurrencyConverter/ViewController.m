//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Alexey Huralnyk on 12/21/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import <CurrencyRequest/CRCurrencyRequest.h>
#import <CurrencyRequest/CRCurrencyResults.h>


@interface ViewController () <CRCurrencyRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySwitcher;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *EUR;
@property (weak, nonatomic) IBOutlet UILabel *JPY;
@property (weak, nonatomic) IBOutlet UILabel *GPB;
@property (nonatomic) CRCurrencyRequest *request;

@end

@implementation ViewController

- (IBAction)convertButtonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.request = [[CRCurrencyRequest alloc] init];
    self.request.delegate = self;
    [self.request start];
}

- (void)currencyRequest:(CRCurrencyRequest *)req retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = YES;
    
    double inputValue = [self.inputField.text floatValue];
    
    if (self.currencySwitcher.selectedSegmentIndex == 1) {
        inputValue /= currencies.EUR;
    } else if (self.currencySwitcher.selectedSegmentIndex == 2) {
        inputValue /= currencies.GBP;
    }
    
    double euroValue = inputValue * currencies.EUR;
    double yenValue = inputValue * currencies.JPY;
    double poundValue = inputValue * currencies.GBP;
    
    self.EUR.text = [NSString stringWithFormat:@"%.2f", euroValue];
    self.JPY.text = [NSString stringWithFormat:@"%.2f", yenValue];
    self.GPB.text = [NSString stringWithFormat:@"%.2f", poundValue];
}


@end
