//
//  ViewController.m
//  TwitterShare
//
//  Created by Alexey Huralnyk on 11/14/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

- (void)configureTweetTextViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextViews];
}

- (void)showAlertMessage:(NSString *)myMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)tweetAction:(id)sender {
    [self resignFirstRespondersIfNeeded];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // Tweet out the tweet
        if ([self.tweetTextView.text length] < 140) {
            [twitterVC setInitialText:self.tweetTextView.text];
        } else {
            NSString *shortText = [self.tweetTextView.text substringToIndex:140];
            [twitterVC setInitialText:shortText];
        }
        
        [self presentViewController:twitterVC animated:YES completion:nil];
        
    } else {
        // Raise some kind of objection
        [self showAlertMessage:@"You are not signed in to Twitter"];
    }
}

- (IBAction)postToFacebookAction:(id)sender {
    [self resignFirstRespondersIfNeeded];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.facebookTextView.text];
        
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    } else {
        [self showAlertMessage:@"Please sign in to Facebook"];
    }
}

- (IBAction)shareAction:(id)sender {
    [self resignFirstRespondersIfNeeded];
    
    UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextView.text]
                                                                         applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}

- (IBAction)showAlertAction:(id)sender {
    [self resignFirstRespondersIfNeeded];
    [self showAlertMessage:@"This doesn't do anything"];
}

- (void)configureTweetTextViews {
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:0
                                                               green:91.0/255.0
                                                                blue:187.0/255.0
                                                               alpha:0.7].CGColor;
    self.tweetTextView.layer.cornerRadius = 6.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
    
    self.facebookTextView.layer.backgroundColor = [UIColor colorWithRed:1.0
                                                                  green:213.0/255.0
                                                                   blue:0
                                                                  alpha:0.7].CGColor;
    self.facebookTextView.layer.cornerRadius = 6.0;
    self.facebookTextView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    self.facebookTextView.layer.borderWidth = 2.0;
    
    self.moreTextView.layer.backgroundColor = [UIColor colorWithRed:26.0/255.0
                                                              green:188.0/255.0
                                                               blue:59.0/255.0
                                                              alpha:0.7].CGColor;
    self.moreTextView.layer.cornerRadius = 6.0;
    self.moreTextView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    self.moreTextView.layer.borderWidth = 2.0;
}

- (void)resignFirstRespondersIfNeeded {
    if ([self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    } else if ([self.facebookTextView isFirstResponder]) {
        [self.facebookTextView resignFirstResponder];
    } else if ([self.moreTextView isFirstResponder]) {
        [self.moreTextView resignFirstResponder];
    }
}

@end
