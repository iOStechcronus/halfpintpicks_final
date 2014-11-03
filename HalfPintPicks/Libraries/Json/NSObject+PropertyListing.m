//
//  NSObject+PropertyListing.m
//  PropertyFun
//
//  Created by Andrew Sardone on 8/27/10.
//

#import "NSObject+PropertyListing.h"

#import <objc/runtime.h>

@implementation NSObject (PropertyListing)

- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithUTF8String:property_getName(property)];
        
        NSString* propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSArray* splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];

        id propertyValue;
        if ([splitPropertyAttributes count] >= 2)
        {
            if([splitPropertyAttributes[1] isEqualToString:@"NSUUID"])
                propertyValue = [NSString stringWithFormat:@"%@",[(NSUUID *)[self valueForKey:(NSString *)propertyName] UUIDString]];
            else if([splitPropertyAttributes[1] isEqualToString:@"NSDate"])
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                propertyValue = [dateFormat stringFromDate:[self valueForKey:(NSString *)propertyName]];
            }
            else if([splitPropertyAttributes[1] isEqualToString:@"GlucoseSettings"] || [splitPropertyAttributes[1] isEqualToString:@"SystemSettings"] || [splitPropertyAttributes[1] isEqualToString:@"ASSettings"] ||[splitPropertyAttributes[2] rangeOfString:@"deviceClassDurationSettings"].location != NSNotFound)
            {
                continue;
            }
            else
            {
                if([self valueForKey:(NSString *)propertyName] != nil)
                    propertyValue = [NSString stringWithFormat:@"%@",[self valueForKey:(NSString *)propertyName]];
            }
        }
        else
        {
            if([self valueForKey:(NSString *)propertyName] != nil)
                propertyValue = [self valueForKey:(NSString *)propertyName];
        }
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end
