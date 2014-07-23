//
//  ViewController.m
//  SparkCoreLib
//
//  Created by Jon Hoffman on 7/21/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

#import "ViewController.h"
#import "SparkCoreConnector.h"
#import "SparkTransactionPost.h"
#import "SparkTransactionGet.h"

#define ACCESS_TOKEN @"1234567890"
#define DEVICE_ID @"my-core"
#define FUNCTION @"led"
#define COUNT_VAR @"myvar"

#define LED_USER @"D7"
#define LED_1 @"D0"
#define LED_2 @"D5"

#define STATE_HIGH @"HIGH"
#define STATE_LOW @"LOW"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_led1Switch setOn:NO animated:YES];
    [_led2Switch setOn:NO animated:YES];
    [_ledUserSwitch setOn:NO animated:YES];
    [self getCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getCountPressed:(id)sender {
    [self getCount];
}

-(void)getCount {
    SparkTransactionGet *getTransaction = [[SparkTransactionGet alloc] initWithAccessToken:ACCESS_TOKEN deviceId:DEVICE_ID andProperty:COUNT_VAR];
    
    [SparkCoreConnector connectToSparkAPIWithTransaction:getTransaction andHandler:^(NSURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        if(error == nil) {
            NSLog(@"Response: %@",responseDictionary);
            NSString *cnt = [responseDictionary objectForKey:@"result"];
            _countLabel.text = [NSString stringWithFormat:@"Count:  %@", cnt];
        } else {
            NSLog(@"Error: %@",error);
            _countLabel.text = @"Error Getting Count";
        }
    }];
}

-(IBAction)ledUserSwitchAction:(id)sender {
    NSString *pin = LED_USER;
    NSString *state = STATE_HIGH;
    if (_ledUserSwitch.on)
        state = STATE_LOW;
    NSString *param = [NSString stringWithFormat:@"%@:%@",pin,state];
    [self sendRequestWithParameter:param];
}

-(IBAction)led1SwitchAction:(id)sender {
    NSString *pin = LED_1;
    NSString *state = STATE_HIGH;
    if (_led1Switch.on)
        state = STATE_LOW;
    NSString *param = [NSString stringWithFormat:@"%@:%@",pin,state];
    [self sendRequestWithParameter:param];
}

-(IBAction)led2SwitchAction:(id)sender {
    NSString *pin = LED_2;
    NSString *state = STATE_HIGH;
    if (_led2Switch.on)
        state = STATE_LOW;
    NSString *param = [NSString stringWithFormat:@"%@:%@",pin,state];
    [self sendRequestWithParameter:param];
}

-(void)sendRequestWithParameter:(NSString *)parameter {
    NSLog(@"Params: %@",parameter);
    SparkTransactionPost *postTransaction = [[SparkTransactionPost alloc] initWithAccessToken:ACCESS_TOKEN deviceId:DEVICE_ID functionName:FUNCTION andParameters:parameter];
    
    [SparkCoreConnector connectToSparkAPIWithTransaction:postTransaction andHandler:^(NSURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        if(error == nil) {
            NSLog(@"Response: %@",responseDictionary);
        } else {
            NSLog(@"Error: %@",error);
        }
    }];
    
    NSLog(@"Continueing with app");
    
}

@end
