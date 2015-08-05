//
//  BQFormatter.m
//  Common Library
//
//  Created CHAU WING WAI on 24/1/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import "BQFormatter.h"
//--------------------------------------------------------------------------------------------------
@implementation BQFormatter
//--------------------------------------------------------------------------------------------------
+ (NSNumber*)numberFromString:(NSString*)string {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    //Set the locale to US
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //Set the number style to Scientific
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* number = [numberFormatter numberFromString:string];
    return number;
}

+ (float)floatNumber:(float)floatNumber decimalPlace:(int)decimalPlace {
    NSString* stringFromFloatNumber = NSStringFromFloat(floatNumber, decimalPlace);
    return [stringFromFloatNumber floatValue];
}

@end

//--------------------------------------------------------------------------------------------------
@implementation NSString (DateFormat)

- (NSDate *)date {
    return [self dateWithFormat:DATE_FORMAT];
}

- (NSDate *)dateWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    return [dateFormatter dateFromString:self];
}

@end
//--------------------------------------------------------------------------------------------------
@implementation NSDate (DateFormat)

- (NSString *)string {
    return [self stringWithFormat:DATE_FORMAT];
}

- (NSString *)stringWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    return [dateFormatter stringFromDate:self];
}

@end
//--------------------------------------------------------------------------------------------------