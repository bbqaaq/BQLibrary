//
//  BQStringExtension.h
//  Common Library
//
//  Created CHAU WING WAI on 7/2/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import "BQLibrary.h"

@interface NSString (BQStringExtension)

//--------------------------------------------------------------------------------------------------
+ (BOOL)isEmptyString:(NSString*)string;
- (BOOL)isInteger;

@end

@interface NSString (TrimmingAdditions)

//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
//--------------------------------------------------------------------------------------------------
- (NSString *)stringByTrimmingLeadingWhitespace;
- (NSString *)stringByTrimmingTrailingWhitespace;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewline;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewline;

@end

@interface NSString (CheckingValidity)

- (BOOL) isValidEmail;
- (BOOL) isValidPhoneNumber;

@end