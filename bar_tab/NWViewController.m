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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
    locationManager.distanceFilter = 10; // meters
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
    [self.locationMeasurements addObject:location];
    CLLocationDistance distance = [self.locationMeasurements[0] distanceFromLocation:[self.locationMeasurements lastObject]];
    NSLog(@"%g", distance);
    if (distance > 300) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"WoaH" message:@"You may have forgotten to close you're tab" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alerView show];
    }

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





@end
