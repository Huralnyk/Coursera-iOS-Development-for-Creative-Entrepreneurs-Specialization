//
//  ViewController.m
//  FourPaneDemo
//
//  Created by Alexey Huralnyk on 1/24/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the web page
    NSString *webURL = @"http://www.cbgb.com/";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [self.webView loadRequest:request];
    
    // Center the map
    double latitude = 40.7314472;
    double longitude = -74.0023382;
    
    MKPointAnnotation *cbgbAnnotation = [[MKPointAnnotation alloc] init];
    cbgbAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    cbgbAnnotation.title = @"CBGB";
    
    [self.mapView addAnnotation:cbgbAnnotation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cbgbAnnotation.coordinate, 1000, 1000);
    MKCoordinateRegion adjusted = [self.mapView regionThatFits:region];
    
    [self.mapView setRegion:adjusted animated:YES];
}

@end
