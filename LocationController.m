//
//  LocationController.m
//  untitled
//
//  Created by Christian Wen on 10/15/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import "LocationController.h"

@interface LocationController () <CLLocationManagerDelegate>
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite, weak) id<LocationControllerDelegate> delegate;
@property (nonatomic, readwrite, strong) CLLocation *lastLocation;
@end

@implementation LocationController

- (instancetype)initWithDelegate:(id<LocationControllerDelegate>)delegate {
    if ((self = [super init])) {
        _delegate = delegate;
    }
    return self;
}

- (void)createLocationManager {
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [[self locationManager] setDelegate:self];
}

- (void)startLocationUpdates {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [[self locationManager] requestWhenInUseAuthorization];
    } else {
        [[self locationManager] startUpdatingLocation];
    }
}

- (void)stopLocationUpdates {
    [[self locationManager] stopUpdatingLocation];
}

#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (manager == [self locationManager]) {
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [[self locationManager] startUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (manager == [self locationManager]) {
        CLLocation *lastLocation = (CLLocation *) [locations lastObject];
        [self setLastLocation:lastLocation];
        [[self delegate] locationController:self didUpdateLocation:lastLocation];
        if ([self continuousUpdates] == NO) {
            [self stopLocationUpdates];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (manager == [self locationManager]) {
        [[self delegate] locationController:self didFailWithError:error];
        if ([error code] == kCLErrorDenied) {
            [self stopLocationUpdates];
        }
    }
}

@end
