//
//  NSObject+PropertyListing.h
//  PropertyFun
//
//  Created by Andrew Sardone on 8/27/10.
//

#import <Foundation/Foundation.h>


@interface NSObject (PropertyListing)

// aps suffix to avoid namespace collsion
//   ...for Andrew Paul Sardone
- (NSDictionary *)properties_aps;

@end
