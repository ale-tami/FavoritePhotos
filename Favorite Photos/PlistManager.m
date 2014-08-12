//
//  PlistManager.m
//  Favorite Photos
//
//  Created by Alejandro Tami on 11/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PlistManager.h"

@interface PlistManager ()

@property NSURL* directory;

@end


@implementation PlistManager

static PlistManager *plistManager = nil;

+ (instancetype) getInstance
{
    if (plistManager) {
        return plistManager;
    } else {
        plistManager = [PlistManager new];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *directories = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        plistManager.directory = directories.firstObject;
    
        return plistManager;
    }
}


- (void) serializeFavoriteImage: (UIImage *)image
{
    NSURL *plistUrl = [self.directory URLByAppendingPathComponent:@"favorites.plist"];
    
    NSMutableArray * newArray = [self deserializeData];
    if (!newArray) {
        newArray = [NSMutableArray new];
    }
    [newArray addObject:UIImagePNGRepresentation(image)];
    
    BOOL success = [newArray writeToURL:plistUrl atomically:YES];
    NSLog(success ? @"Yes" : @"No");
    
}

- (NSMutableArray*) deserializeData
{
    NSURL *plistUrl = [self.directory URLByAppendingPathComponent:@"favorites.plist"];
    return [NSMutableArray arrayWithContentsOfURL:plistUrl];
}

- (NSArray*) deserializeFavoriteImages
{
     NSURL *plistUrl = [self.directory URLByAppendingPathComponent:@"favorites.plist"];
    
    NSMutableArray *aux = [NSMutableArray new];
    
    for (NSData *data in [NSArray arrayWithContentsOfURL:plistUrl]) {
        [aux addObject:[UIImage imageWithData:data ]];
    }
    
    return (NSArray*)aux ;
}

@end