//
//  DataModel.h
//  LFC
//
//  Created by OSX on 13/07/16.
//  Copyright © 2016 OSX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestCompletionBlock)(id response, NSError *error);


@interface DataModel : NSObject
{
    //blocks
    RequestCompletionBlock dataBlock;
}





+ (id) sharedDataManager;

-(void)Api:(NSString *)url Data:(NSDictionary *)Dict  withBlock:(RequestCompletionBlock)block;;

@end
