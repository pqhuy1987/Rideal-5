//
//  DataModel.m
//  LFC
//
//  Created by OSX on 13/07/16.
//  Copyright © 2016 OSX. All rights reserved.
//

#import "DataModel.h"
#import "AFNetworking.h"


@implementation DataModel
+ (id) sharedDataManager {\
    static dispatch_once_t pred = 0;\
    static id _sharedObject = nil;\
    dispatch_once(&pred, ^{\
        _sharedObject = [[self alloc] init];\
    });\
    return _sharedObject;\
}

-(void)Api:(NSString *)url Data:(NSDictionary *)Dict withBlock:(RequestCompletionBlock)block
{
    if (block) {
        dataBlock=[block copy];
    }
// //
    
    NSLog(@"%@",url);
    NSString *feedStr = [NSString stringWithFormat:@"%@",url];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    
    
    [manager POST:feedStr parameters:Dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",[responseObject description]);
        
        
        NSLog(@"JSON: %@", responseObject);
        
        //         NSString * message = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]];
        
        if (dataBlock) {
            dataBlock(responseObject,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
        
        NSLog(@"ERROR: %@",error.localizedDescription);
        if (dataBlock) {
            dataBlock(nil,error);
        }
        
    }];

}

@end
