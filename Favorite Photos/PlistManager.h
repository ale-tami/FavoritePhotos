//
//  PlistManager.h
//  Favorite Photos
//
//  Created by Alejandro Tami on 11/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

+ (instancetype) getInstance;

- (void) serializeFavoriteImage: (UIImage *)image;
- (NSArray*) deserializeFavoriteImages;
- (NSArray*) removeFromFavorites:(UIImage *)image;

@end
