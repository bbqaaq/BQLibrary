//
//  BQAssetsLibrary.m
//  Common Library
//
//  Created CHAU WING WAI on 10/2/14.
//  Copyright (c) 2014 CHAU WING WAI. All rights reserved.
//

//--------------------------------------------------------------------------------------------------
#import "BQAssetsLibrary.h"
//--------------------------------------------------------------------------------------------------
@implementation BQAssetsLibrary

@synthesize albumName = _albumName;
@synthesize library = _library;
//--------------------------------------------------------------------------------------------------
static BQAssetsLibrary *_sharedInstance = nil;

#pragma mark - Share Instance
//--------------------------------------------------------------------------------------------------
+ (BQAssetsLibrary *)sharedInstance {
	if (_sharedInstance != nil) {return _sharedInstance;}
	
	_sharedInstance = [[BQAssetsLibrary alloc] init];
    
	return _sharedInstance;
}

#pragma mark - Init and dealloc
//--------------------------------------------------------------------------------------------------
- (id)init {
	NSLog(@"[BQAssetsLibrary init]");
	
	self = [super init];
	if (self == nil)  {return self;}
    
    self.library = [[ALAssetsLibrary alloc] init];
    self.albumName = @"Untitled Album";
    
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied
        ||[ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
        [self showAlertForRequireAccessRight];
    }
    
    return self;
}
//--------------------------------------------------------------------------------------------------
- (void)dealloc {
    NSLog(@"[BQAssetsLibrary dealloc]");
    
    self.library = nil;
}
#pragma mark - Custom Function
//--------------------------------------------------------------------------------------------------
- (void)showAlertForRequireAccessRight {
    UIAlertView* alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.notauthorized.title", BQLIBRARY_LOCALIZED_STRING,nil)
                              message:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.notauthorized.message", BQLIBRARY_LOCALIZED_STRING, nil)
                              delegate:self
                              cancelButtonTitle:NSLocalizedStringFromTable(@"common.alertview.button.OK", BQLIBRARY_LOCALIZED_STRING,nil)
                              otherButtonTitles:nil, nil];
    [alertView show];
}
//--------------------------------------------------------------------------------------------------
- (void)showAlertForNotEnoughSpace {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.nospace.title", BQLIBRARY_LOCALIZED_STRING,nil)
                                                        message:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.nospace.message", BQLIBRARY_LOCALIZED_STRING,nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedStringFromTable(@"common.alertview.button.OK", BQLIBRARY_LOCALIZED_STRING,nil)
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
//--------------------------------------------------------------------------------------------------
- (void)showAlertForOtherError {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.unknownerror.title", BQLIBRARY_LOCALIZED_STRING,nil)
                                                        message:NSLocalizedStringFromTable(@"bqassetslibrary.alertview.unknownerror.message", BQLIBRARY_LOCALIZED_STRING,nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedStringFromTable(@"common.alertview.button.OK", BQLIBRARY_LOCALIZED_STRING,nil)
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
//--------------------------------------------------------------------------------------------------
- (void)handleError:(NSError*)error {
    NSLog(@"[BQAssetsLibrary handleError] %@",error);
    if ([error code] == ALAssetsLibraryAccessGloballyDeniedError
        ||[error code] == ALAssetsLibraryAccessUserDeniedError) {
        [self showAlertForRequireAccessRight];
    }
    else if ([error code] == ALAssetsLibraryWriteDiskSpaceError) {
        [self showAlertForNotEnoughSpace];
    }
    else {
        [self showAlertForOtherError];
    }
}
//--------------------------------------------------------------------------------------------------
//  error = nil if success
- (void)saveImage:(UIImage*)image completionBlock:(void (^) (NSString* urlPath, NSError* error))completionBlock {
    //
    WEAKSELF(weakSelf);
    [self.library addAssetsGroupAlbumWithName:self.albumName resultBlock:^(ALAssetsGroup *group) {
        //  checks if group previously created
        if(group == nil) {
            //  already exist, enumerate albums
            [weakSelf.library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                        usingBlock:^(ALAssetsGroup *resultGroup, BOOL *stop) {
                                            //if the album is equal to our album
                                            if ([[resultGroup valueForProperty:ALAssetsGroupPropertyName] isEqualToString:weakSelf.albumName]) {
                                                [weakSelf saveImage:image toAssetsGroup:resultGroup completionBlock:completionBlock];
                                                *stop = YES;
                                            }
                                        }
                                      failureBlock:^(NSError *error) {
                                          [weakSelf handleError:error];
                                          completionBlock(nil, error);
                                      }];
            
        }
        else {
            [weakSelf saveImage:image toAssetsGroup:group completionBlock:completionBlock];
        }
        
    }
    failureBlock:^(NSError *error) {
        [weakSelf handleError:error];
        completionBlock(nil, error);
    }];
}
//--------------------------------------------------------------------------------------------------
- (void)saveImage:(UIImage*)image toAssetsGroup:(ALAssetsGroup*)assetsGroup completionBlock:(void (^) (NSString* urlPath, NSError* error))completionBlock {
    [self.library writeImageDataToSavedPhotosAlbum:UIImageJPEGRepresentation(image,1.0f) metadata:nil
                                   completionBlock:^(NSURL *assetURL, NSError *error) {
                                       if (error) {
                                           [self handleError:error];
                                           completionBlock(nil, error);
                                           return;
                                       }
                                       [self.library assetForURL:assetURL
                                                     resultBlock:^(ALAsset *asset) {
                                                         [assetsGroup addAsset:asset];
                                                         NSString* urlPath = [assetURL absoluteString];
                                                         completionBlock(urlPath, nil);
                                                     }
                                                    failureBlock:^(NSError *error) {
                                                        [self handleError:error];
                                                        completionBlock(nil, error);
                                                    }];
                                   }];
}
//--------------------------------------------------------------------------------------------------
- (void)loadImage:(NSString*)urlPath resultBlock:(void (^)(UIImage *))resultBlock {
//    NSURL* assetUrl = [NSURL URLWithString:urlPath];
    
    if(![NSString isEmptyString:urlPath]) {
        NSURL *asseturl = [NSURL URLWithString:urlPath];
        [self.library assetForURL:asseturl
                      resultBlock:^(ALAsset *asset) {
                          ALAssetRepresentation *rep = [asset defaultRepresentation];
                          CGImageRef iref = [rep fullResolutionImage];
                          if (iref) {
                              UIImage *largeimage = [UIImage imageWithCGImage:iref];
                              resultBlock(largeimage);
                          }
                          else {
                              resultBlock(nil);
                          }
                      }
         
                     failureBlock:^(NSError *error) {
                         NSLog(@"[BQAssetsLibrary loadImage] %@",error);
                         resultBlock(nil);
                     }
         ];
    }
    else {
        resultBlock(nil);
    }
    
    return;
}

@end
