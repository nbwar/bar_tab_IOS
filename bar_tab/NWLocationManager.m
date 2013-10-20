//
//  NWLocationManager.m
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWLocationManager.h"

@implementation NWLocationManager

-(CLLocationManager *)locationManager
{
    if(!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}


-(void)starLocationManager
{
    [self.locationManager startUpdatingLocation];
}

@end
