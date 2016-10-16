//
//  MapViewController.h
//  untitled
//
//  Created by Christian Wen on 10/15/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController : UIViewController
@property (nonatomic, readwrite, strong) CLLocation *location;
@end
