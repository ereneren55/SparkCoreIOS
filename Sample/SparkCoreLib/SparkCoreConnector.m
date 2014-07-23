//
//  SparkCoreConnector.m
//  SparkCoreLib
//
//  Created by Jon Hoffman on 7/21/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

#import "SparkCoreConnector.h"

@implementation SparkCoreConnector

@synthesize sessionConfiguration,queue, baseUrl, accessToken, deviceId, functionName;

// Default initiator that sets everything to default values
-(instancetype)init {
    self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.queue = [NSOperationQueue currentQueue];
    self.baseUrl = @"https://api.spark.io/v1/devices";
    self.accessToken = @"";
    self.deviceId = @"";
    self.parameters = @"";
    self.functionName = @"";
    return self;
}

//  initiator that sets everything to default using the default init method
//  then sets the accessToken and deviceId properties
-(instancetype)initWithAccessToken:(NSString *)token andDeviceId:(NSString *)devId {
    self = [self init];
    if (self) {
        self.accessToken = token;
        self.deviceId = devId;
    }
    return self;
}

//  initiator that uses the initWithAccessToken:andDeviceId: initiator and then sets the functionName property
-(instancetype)initWithAccessToken:(NSString *)token deviceId:(NSString *)devId andFunctionName:(NSString*)function{
    self = [self initWithAccessToken:token andDeviceId:devId];
    if (self) {
        self.functionName = function;
    }
    return self;
}

//  initiator that uses the initWithAccessToken:deviceId:andFunctionName: initiator and then sets the parameters property
-(instancetype)initWithAccessToken:(NSString *)token deviceId:(NSString *)devId functionName:(NSString *)function andParameters:(NSString*)params{
    self = [self initWithAccessToken:token deviceId:devId andFunctionName:function];
    if (self) {
        self.parameters = params;
    }
    return self;
}

//  Connects to the Spark API
-(void)connectWithCompletionHandler:(connectClosure)handler; {
    NSString *mUrl = [NSString stringWithFormat:@"%@/%@/%@",self.baseUrl,self.deviceId,self.functionName];
    NSLog(@"mUrl:  %@", mUrl);
    NSURL *url = [NSURL URLWithString:mUrl];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:nil delegateQueue:self.queue];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *params = [NSString stringWithFormat:@"access_token=%@&params=%@",self.accessToken,self.parameters];

    request.HTTPMethod = @"POST";
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *uploadTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (error == nil) {
 
            NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            handler(response,retData,error);
        } else {
            handler(response,nil,error);
        }
    }];
    
    
    [uploadTask resume];
}


@end
