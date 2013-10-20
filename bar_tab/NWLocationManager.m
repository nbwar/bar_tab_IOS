//
//  NWLocationManager.m
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWLocationManager.h"

@interface NWLocationManager()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation NWLocationManager

-(CLLocationManager *)locationManager
{
    if(!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}


-(void)startLocationManager
{
    NSLog(@"Starting Location Manager");
//    if (nil == self.locationManager)
//        self.locationManager = [[CLLocationManager alloc] init];
    
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
//    [self.locationMeasurements addObject:location];
//    CLLocationDistance distance = [self.locationMeasurements[0] distanceFromLocation:[self.locationMeasurements lastObject]];
//    NSLog(@"%g", distance);
//    if (distance > 300) {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"WoaH" message:@"You may have forgotten to close you're tab" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [alerView show];
//    }
    
    //    NSDate* eventDate = location.timestamp;
    //    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
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
