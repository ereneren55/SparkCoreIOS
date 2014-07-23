//
//  SparkCoreConnector.h
//  SparkCoreLib
//
//  Created by Jon Hoffman on 7/21/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SparkCoreConnector : NSObject

typedef void (^connectClosure)(NSURLResponse *response, NSDictionary *responseDictionary, NSError *error);

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfiguration;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *parameters;
@property (strong, nonatomic) NSString *functionName;

-(instancetype)initWithAccessToken:(NSString *)token andDeviceId:(NSString *)devId;
-(instancetype)initWithAccessToken:(NSString *)token deviceId:(NSString *)devId andFunctionName:(NSString*)function;
-(instancetype)initWithAccessToken:(NSString *)token deviceId:(NSString *)devId functionName:(NSString *)function andParameters:(NSString*)params;
-(void)connectWithCompletionHandler:(connectClosure)handler;


@end
