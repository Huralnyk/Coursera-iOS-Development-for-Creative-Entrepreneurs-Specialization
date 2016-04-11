//
//  ViewController.m
//  GeoFence Coupons
//
//  Created by Alexey Huralnyk on 3/31/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLCircularRegion *region;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLocationRegion];
    [self setupLocationManager];
    [self setupPermissions];
}

- (void)setupLocationRegion {
    self.region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(50.467447, 30.510794) radius:10 identifier:@"Hobot Comics Shop"];
}

- (void)setupAnnotation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(50.467447, 30.510794);
    annotation.title = @"Hobot Comics Shop";
    annotation.subtitle = @"I assure you we're open";
    [self.mapView addAnnotation:annotation];
}

- (void)setupLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)setupPermissions {
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status != kCLAuthorizationStatusAuthorizedAlways || status != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#pragma mark - Map View Delegate
#

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:true];
}


#pragma mark - Location Manager Delegate
#

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        // Zoom Map View
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.centerCoordinate, 500, 500);
        MKCoordinateRegion adjusted = [self.mapView regionThatFits:region];
        [self.mapView setRegion:adjusted animated:YES];

        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startMonitoringForRegion:self.region];
        [self setupAnnotation];
    } else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopMonitoringForRegion:self.region];
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertTitle = @"Check this out!";
    notification.alertBody = @"You coupon code 'HOBOT42'. Use this code to get the 10% off a purchase in the next 30 minutes at Hobot Comic Shop.";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
