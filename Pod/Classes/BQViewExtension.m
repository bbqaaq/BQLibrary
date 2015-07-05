//
//  BQViewExtension.m
//  Common Library
//
//  Created CHAU WING WAI on 10/2/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import "BQViewExtension.h"

@implementation UIView (BQViewExtension)

- (UIImage*)imageView {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
