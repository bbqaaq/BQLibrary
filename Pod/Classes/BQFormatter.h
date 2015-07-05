//
//  BQFormatter.h
//  Common Library
//
//  Created CHAU WING WAI on 24/1/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "BQLibrary.h"

#define IntFromBOOL(b)                              b?1:0
#define NSStringFromBOOL(b)                         b?@"YES":@"NO"
#define NSStringFromInt(i)                          [NSString stringWithFormat:@"%d",i]
#define NSStringFromFloat(num,dp)                   [NSString stringWithFormat:[NSString stringWithFormat:@"%%.%df",dp],num]

//#define DATE_FORMAT_SQLITE                          @"yyyy-mm-dd hh:"
//--------------------------------------------------------------------------------------------------
@interface BQFormatter : NSObject

+ (NSNumber*)numberFromString:(NSString*)string;

+ (float)floatNumber:(float)floatNumber decimalPlace:(int)decimalPlace;

@end