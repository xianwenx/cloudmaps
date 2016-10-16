//
//  MapViewController.m
//  untitled
//
//  Created by Christian Wen on 10/15/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController ()

@end

@implementation MapViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

- (void)setLocation:(CLLocation*)location {
    _location = location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    GMSCameraPosition *cameraPosition = [[GMSCameraPosition alloc] initWithTarget:coordinate
                                                                             zoom:15
                                                                          bearing:0
                                                                     viewingAngle:0];
    [[self mapView] setCamera:cameraPosition];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (GMSMapView *)mapView {
    GMSMapView *result = nil;
    UIView *view = [self view];
    if ([view isKindOfClass:[GMSMapView class]]) {
        result = (GMSMapView *)view;
    }
    return result;
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:12];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
    
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    mapView.mapStyle = style;
    self.view = mapView;
}

@end
