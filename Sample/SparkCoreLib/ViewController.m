//
//  ViewController.m
//  SparkCoreLib
//
//  Created by Jon Hoffman on 7/21/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

#import "ViewController.h"
#import "SparkCoreConnector.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed:(id)sender {
    SparkCoreConnector *spark = [[SparkCoreConnector alloc]initWithAccessToken:@"0123456789abcdef" deviceId:@"myid" functionName:@"tester" andParameters:@"test param"];
    NSLog(@"Sending Request");
    [spark connectWithCompletionHandler:^(NSURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        if(error == nil) {
            NSLog(@"Response: %@",responseDictionary);
        } else {
            NSLog(@"Error: %@",error);
        }
    }];
    NSLog(@"Continueing with app");
}

@end
