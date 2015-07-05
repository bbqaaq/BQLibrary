//
//  BQStringExtension.m
//  Common Library
//
//  Created CHAU WING WAI on 24/1/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import "BQStringExtension.h"

//--------------------------------------------------------------------------------------------------
@implementation NSString (BQStringExtension)
//--------------------------------------------------------------------------------------------------
+ (BOOL)isEmptyString:(NSString*)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}
//--------------------------------------------------------------------------------------------------
- (BOOL)isInteger {
    //  check if a string is positive or negative, and do not contain any invalid character
    //  e.g. "-123", "333", "123"  is valid
    //  "1.2-3", "1.44f" is invalid

    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([self rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
        return YES;
    }
    else {
        NSRange range = [self rangeOfString:@"-"];
        if (range.location == 0) {
            NSString* positiveString = [self stringByReplacingCharactersInRange:range withString:@""];
            if ([positiveString rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
                return YES;
            }
        }
    }
    return NO;
}

@end


@implementation NSString (TrimmingAdditions)

//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingLeadingWhitespace {
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingTrailingWhitespace {
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewline {
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewline {
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@implementation NSString (CheckValidity)
//--------------------------------------------------------------------------------------------------
- (BOOL) isValidEmail {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//--------------------------------------------------------------------------------------------------
- (BOOL)isValidPhoneNumber {
    NSString *filterString = @"[0-9+]{1,1}+[0-9]{5,14}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [phoneTest evaluateWithObject:self];
}
@end

