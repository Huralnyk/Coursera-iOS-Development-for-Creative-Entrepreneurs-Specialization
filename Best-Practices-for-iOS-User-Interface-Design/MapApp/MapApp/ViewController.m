//
//  ViewController.m
//  MapApp
//
//  Created by Alexey Huralnyk on 2/9/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) MKPointAnnotation *cbgbAnno;
@property (nonatomic) MKPointAnnotation *club100Anno;
@property (nonatomic) MKPointAnnotation *cavernAnno;

@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL isMapMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLocationManager];
    [self loadAnnotations];
}

- (void)configureLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
}

- (void)loadAnnotations {
    self.cbgbAnno = [[MKPointAnnotation alloc] init];
    self.cbgbAnno.coordinate = CLLocationCoordinate2DMake(40.7251654, -73.9942028);
    self.cbgbAnno.title = @"Legendary CBGB";
    
    self.club100Anno = [[MKPointAnnotation alloc] init];
    self.club100Anno.coordinate = CLLocationCoordinate2DMake(51.5161485, -0.1353058);
    self.club100Anno.title = @"100 Club";
    
    self.cavernAnno = [[MKPointAnnotation alloc] init];
    self.cavernAnno.coordinate = CLLocationCoordinate2DMake(53.4063747, -2.9901799);
    self.cavernAnno.title = @"Cavern Club";
    
    [self.mapView addAnnotations:@[self.cbgbAnno, self.club100Anno, self.cavernAnno]];
}



#pragma mark - Actions
#

- (IBAction)onCBGB:(id)sender {
    [self.mapView setCenterCoordinate:self.cbgbAnno.coordinate animated:YES];
}

- (IBAction)on100Club:(id)sender {
    [self.mapView setCenterCoordinate:self.club100Anno.coordinate animated:YES];
}

- (IBAction)onCavern:(id)sender {
    [self.mapView setCenterCoordinate:self.cavernAnno.coordinate animated:YES];
}

- (IBAction)onLocateMe:(id)sender {
    UISwitch *locateMeSwitch = (UISwitch *)sender;
    
    CLAuthorizationStatus auth = [CLLocationManager authorizationStatus];
    
    if (auth != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locateMeSwitch setOn:NO animated:YES];
        [self.locationManager requestWhenInUseAuthorization];
        return;
    }
    
    if (locateMeSwitch.isOn) {
        self.mapView.showsUserLocation = YES;
    } else {
        self.mapView.showsUserLocation = NO;
    }
}


#pragma mark - MKMapViewDelegate
#

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.isMapMoving = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.isMapMoving = NO;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.isMapMoving) {
        [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    }
}

@end
