//
//  ApiRequest.m
//  JsonParsing
//
//  Created by TechCronus on 29/07/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "ApiRequest.h"

@implementation ApiRequest
{
    NSURLConnection *getRequestconnection;
    NSURLConnection *postRequestconnection;
    NSURLConnection *multiformPostRequestconnection;
    int requestIdForJson,requestIdForMultiform,requestIdForJsonGet;
}

@synthesize responseData;
@synthesize apiRequestDelegate;



/*
 <Method Name> sendJsonPostRequestwithurl </Method Name>
 <Summary>
        This Method to send Post Request with Json data  to url which you will provide . Please Also pass proper RequestID Parameter to get proper reaponse with data.
 </Summary>
 
 <Parameters>
    <key>Url </key>
        <type>String</type>
 
    <key>PostData </key>
        <type>String</type>
 
    <key>requestId </key>
        <type>integer</type>
 </Parameters>
 
 <CreatedBy> TechCronus </CreatedBy>
 <CreatedDate> 01.10.2014 </CreatedDate>
 */

-(void)sendJsonPostRequestwithurl:(NSString *)url postData :(NSString *)jsonString requestId :(int)requetId {

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlString = [NSURL URLWithString:url];
    requestIdForJson = requetId;
 
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSData *myRequestData = [NSData dataWithBytes: [jsonString UTF8String] length: [jsonString length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: myRequestData];
    
    // Create url connection and fire request
    postRequestconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [postRequestconnection start];
}

/*
 <Method Name> sendJsonPostRequestwithurl </Method Name>
 <Summary>
        This Method to Get Request from url which you will provide . Please Also pass proper RequestID Parameter to get proper reaponse with data.
 </Summary>
 <Parameters>
 
    <key>Url </key>
        <type>String</type>
    <key>requestId </key>
        <type>integer</type>
 
 </Parameters>
 
 <CreatedBy> TechCronus </CreatedBy>
 <CreatedDate> 01.10.2014 </CreatedDate>
 */
-(void)sendJsonGetRequestwithurl:(NSString *)url requestId :(int)requetId{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    requestIdForJsonGet = requetId;
    NSURL *urlString = [NSURL URLWithString:url];
    // Create the request.
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    // Create url connection and fire request
    getRequestconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [getRequestconnection start];
}

/*
 <Method Name> sendJsonPostRequestwithurl </Method Name>
 <Summary>
        This Method to send Post Request with Multiform data to url which you will provide . Please Also pass proper RequestID Parameter to get proper reaponse with data.
 </Summary>
 <Parameters>
 
    <key>Url </key>
        <type>String</type>
 
    <key>PostData </key>
        <type>String</type>
 
    <key>requestId </key>
        <type>integer</type>
 
 </Parameters>
 
 <CreatedBy> TechCronus </CreatedBy>
 <CreatedDate> 01.10.2014 </CreatedDate>
 */

-(void)sendMultiformPostRequestwithurl:(NSString *)url postData :(NSString *)jsonString requestId :(int)requetId{
    
    // Create the request.
    requestIdForMultiform = requetId;
    NSString *urlString = @"";
    urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    
    NSData *myRequestData = [NSData dataWithBytes: [jsonString UTF8String] length: [jsonString length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: myRequestData];
    
    // Create url connection and fire request
    multiformPostRequestconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [multiformPostRequestconnection start];
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([(NSHTTPURLResponse*)response statusCode] >= 200 &&
        [(NSHTTPURLResponse*)response statusCode] < 400)
    {
    }
    else if ([(NSHTTPURLResponse*)response statusCode] > 400)
    {
    }
    
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    if(connection == postRequestconnection)
    {
        [apiRequestDelegate apiRequestCompletedWithData:responseData requestId:requestIdForJson];
    }
    else if(connection == getRequestconnection)
    {
        [apiRequestDelegate apiRequestCompletedWithData:responseData requestId:requestIdForJsonGet];
    }
    else
    {
        [apiRequestDelegate apiRequestCompletedWithData:responseData requestId:requestIdForMultiform];
    }

}

#pragma Failed With Error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if(connection == postRequestconnection)
    {
        [apiRequestDelegate apiRequestCompletedWithError:[error valueForKey:@""] requestId:requestIdForJson];
    }
    else if(connection == getRequestconnection)
    {
        [apiRequestDelegate apiRequestCompletedWithError:[error valueForKey:@""] requestId:requestIdForJsonGet];
    }
    else
    {
        [apiRequestDelegate apiRequestCompletedWithError:[error valueForKey:@""] requestId:requestIdForMultiform];
    }
    
}


@end



