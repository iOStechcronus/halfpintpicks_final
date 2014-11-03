//
//  ApiRequest.h
//  JsonParsing
//
//  Created by TechCronus on 29/07/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiRequestDelegate <NSObject>

@optional
-(void) apiRequestCompletedWithData:(NSMutableData *)responseData requestId:(int)requestId;
-(void) apiRequestCompletedWithError:(NSString *)errorString requestId:(int)requestId;

@end

@interface ApiRequest : NSObject<NSURLConnectionDelegate>

@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,strong) id<ApiRequestDelegate> apiRequestDelegate;

-(void)sendJsonPostRequestwithurl:(NSString *)url postData :(NSString *)jsonString requestId :(int)requetId;

-(void)sendJsonGetRequestwithurl:(NSString *)urlstring requestId :(int)requetId;

-(void)sendMultiformPostRequestwithurl:(NSString *)url postData :(NSString *)jsonString requestId :(int)requetId;

@end
