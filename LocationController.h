//
//  LocationController.h
//  untitled
//
//  Created by Christian Wen on 10/15/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationControllerDelegate;

@interface LocationController : NSObject
@property (nonatomic, readonly, strong) CLLocation *lastLocation;
@property (nonatomic, readwrite, assign) BOOL continuousUpdates;
- (instancetype)init __unavailable;
- (instancetype)initWithDelegate:(id<LocationControllerDelegate>)delegate;

- (void)createLocationManager;
- (void)startLocationUpdates;
- (void)stopLocationUpdates;
@end

@protocol LocationControllerDelegate <NSObject>
- (void)locationController:(LocationController *)locationController didUpdateLocation:(CLLocation *)location;
- (void)locationController:(LocationController *)locationController didFailWithError:(NSError *)error;
@end
