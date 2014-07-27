//
//  ViewController.m
//  SparkComparisonApp
//
//  Created by Jon Hoffman on 7/27/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

#import "ViewController.h"
#import "SparkCoreConnector.h"
#import "SparkTransactionPost.h"
#import "SparkTransactionGet.h"


#define ACCESS_TOKEN @"6ba939bcbd4a241b1d8d564e6c11bdcb5caaebed"
#define DEVICE_ID @"buddy-core"
#define FUNCTION @"led"
#define STATUS_VAR @"ledStatus"

#define LED_USER @"D7"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self sendRequestWithParameter:[self getParameterStringFromState:false]];
    [self getStatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getStatus {
    SparkTransactionGet *getTransaction = [[SparkTransactionGet alloc] initWithAccessToken:ACCESS_TOKEN deviceId:DEVICE_ID andProperty:STATUS_VAR];
    
    [SparkCoreConnector connectToSparkAPIWithTransaction:getTransaction andHandler:^(NSURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        if(error == nil) {
            NSLog(@"Response: %@",responseDictionary);
            int status = [[responseDictionary objectForKey:@"result"] intValue];
        
            NSString *statusStr = @"off";
            if (status == 1)
                statusStr = @"on";
            _statusLabel.text = [NSString stringWithFormat:@"LED is  %@", statusStr];
        } else {
            NSLog(@"Error: %@",error);
            _statusLabel.text = @"Error Getting Count";
        }
    }];
}

-(IBAction)onPressed:(id)sender {
    [self sendRequestWithParameter:[self getParameterStringFromState:true]];
}

-(IBAction)offPressed:(id)sender {
    [self sendRequestWithParameter:[self getParameterStringFromState:false]];
}

-(NSString *)getParameterStringFromState:(bool)state {
    if(state)
        return [NSString stringWithFormat:@"on"];
    else
        return [NSString stringWithFormat:@"off"];
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
         [self getStatus];
    }];
    
    NSLog(@"Continueing with app");
    
}

@end
