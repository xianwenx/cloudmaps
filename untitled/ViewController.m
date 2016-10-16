//
//  ViewController.m
//  untitled
//
//  Created by Christian Wen on 10/15/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "LocationController.h"
#import "MapViewController.h"
#import "UIAlertController+ErrorRecovery.h"
@interface ViewController () <LocationControllerDelegate>
@property (nonatomic, readwrite, strong)    LocationController  *locationController;
@property (nonatomic, readwrite, weak)      MapViewController   *mapViewController;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _locationController = [[LocationController alloc] initWithDelegate:self];
        [_locationController createLocationManager];
        [_locationController startLocationUpdates];

    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _locationController = [[LocationController alloc] initWithDelegate:self];
        [_locationController createLocationManager];
        [_locationController startLocationUpdates];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -- LocationControllerDelegate

- (void)locationController:(LocationController *)locationController didUpdateLocation:(CLLocation *)location {
    if (locationController == [self locationController]) {
        [[self mapViewController] setLocation:location];
    }
}

- (void)locationController:(LocationController *)locationController didFailWithError:(NSError *)error {
    if (locationController == [self locationController]) {
        if ([error code] == kCLErrorDenied) {
            [self presentLocationControllerAlertForError:error];
        }
    }
}

#pragma mark -- Error Handling

- (void)presentLocationControllerAlertForError:(NSError *)error {
    UIAlertController *locationControllerAlertController = [UIAlertController alertControllerWithError:error
                                                                                        preferredStyle:UIAlertControllerStyleAlert
                                                                                       completionBlock:^(BOOL recovered, NSNumber * _Nullable optionIndex)
                                                            {
                                                                
                                                            }];
    [self presentViewController:locationControllerAlertController animated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self) {
        if ([[segue identifier] isEqualToString:@"mapViewControllerEmbedSegue"]) {
            UIViewController *viewController = [segue destinationViewController];
            if ([viewController isKindOfClass:[MapViewController class]]) {
                MapViewController *mapViewController = (MapViewController *)viewController;
                [self setMapViewController:mapViewController];
            }
        }
    }
}

@end
