//
//  BQAssetsLibrary.h
//  Common Library
//
//  Created CHAU WING WAI on 10/2/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "BQLibrary.h"
//--------------------------------------------------------------------------------------------------
@interface BQAssetsLibrary : NSObject {
    NSString* _albumName;
    ALAssetsLibrary* _library;
}

@property (nonatomic, strong) NSString* albumName;
@property (nonatomic, strong) ALAssetsLibrary* library;
//--------------------------------------------------------------------------------------------------
+ (BQAssetsLibrary *)sharedInstance;
#pragma mark - Init and dealloc
- (id)init;

#pragma mark - Custom Function
- (void)showAlertForRequireAccessRight;
- (void)saveImage:(UIImage*)image completionBlock:(void (^) (NSString* urlPath, NSError* error))completionBlock;
- (void)loadImage:(NSString*)urlPath resultBlock:(void (^) (UIImage* image))resultBlock;
@end
