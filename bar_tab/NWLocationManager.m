//
//  NWLocationManager.m
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWLocationManager.h"
#import "NWViewController.h"

@interface NWLocationManager()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NWViewController *viewController;
@property (strong, nonatomic) NSMutableArray *locationsArray;
@end

@implementation NWLocationManager


// LazyI

-(CLLocationManager *)locationManager
{
    if(!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

- (NWViewController *)viewController
{
    if(!_viewController) _viewController = [[NWViewController alloc] init];
    return _viewController;
}

-(NSMutableArray *)locationsArray
{
    if(!_locationsArray) _locationsArray = [[NSMutableArray alloc] init];
    return _locationsArray;
}


-(void)startLocationManager
{
    NSLog(@"Starting Location Manager");
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10; // meters
    [self.locationManager startUpdatingLocation];
}

-(void)stopLocationManager
{
    NSLog(@"Stopping Location Manager");
    [self.locationManager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Locationg..");
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
    }
    CLLocation* location = [locations lastObject];
    [self.locationsArray addObject:location];
    
    CLLocationDistance distance = [self.locationsArray [0] distanceFromLocation:[self.locationsArray lastObject]];

    NSLog(@"%g", distance);
    if (distance > 30) {
        [self.viewController mayHaveLeftBarAlert];
    }
    
    if (isInBackground)
    {
        NSLog(@"BACKGROUND");
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    else
    {
        NSLog(@"RUNNING");
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    
    
}

@end
