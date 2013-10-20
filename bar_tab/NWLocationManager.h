//
//  NWLocationManager.h
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface NWLocationManager : NSObject
@property (strong, nonatomic) CLLocationManager *locationManager;

-(void)starLocationManager;


@end
