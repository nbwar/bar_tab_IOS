//
//  NWViewController.m
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "NWViewController.h"

@interface NWViewController ()

@property (weak, nonatomic) IBOutlet UIButton *tabButtonOutlet;
@property (strong, nonatomic) NSMutableArray *locationMeasurements;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;


- (IBAction)tabButtonPressed:(UIButton *)sender;

@end

@implementation NWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tabButtonPressed:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"Open Tab"]) {
        [sender setTitle:@"Close Tab" forState:UIControlStateNormal];
        [self startMonitoringLocation];
        
    } else {
        [sender setTitle:@"Open Tab" forState:UIControlStateNormal];
        [self stopMonitoringLocation];
    }
}



- (void)startMonitoringLocation
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 0; // meters
    [locationManager startUpdatingLocation];
}

-(void)stopMonitoringLocation
{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
    }
    CLLocation* location = [locations lastObject];
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

-(NSMutableArray *)locationMeasurements
{
    if (!_locationMeasurements) _locationMeasurements = [[NSMutableArray alloc] init];
    return _locationMeasurements;
}

-(void) applicationDidEnterBackground:(UIApplication *) application
{
    [locationManager stopUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
}

-(void) applicationDidBecomeActive:(UIApplication *) application
{
    [locationManager stopMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
}



@end
