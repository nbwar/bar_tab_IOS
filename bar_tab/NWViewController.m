//
//  NWViewController.m
//  bar_tab
//
//  Created by Nicholas Wargnier on 10/19/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//


#import "NWViewController.h"
#import "NWLocationManager.h"

@interface NWViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UIButton *tabButtonOutlet;
@property (strong, nonatomic) NWLocationManager *myLocationManager;

// IBActions
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

// Lazy instantiations
#pragma mark LazyI

-(NWLocationManager *)myLocationManager
{
    if (!_myLocationManager) _myLocationManager = [[NWLocationManager alloc] init];
    return _myLocationManager;
}


// IBAction
#pragma mark IBAction

- (IBAction)tabButtonPressed:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"Open Tab"]) {
        [sender setTitle:@"Close Tab" forState:UIControlStateNormal];
        [self.myLocationManager startLocationManager];
        
    } else {
        [sender setTitle:@"Open Tab" forState:UIControlStateNormal];
        [self.myLocationManager stopLocationManager];
    }
}


@end
