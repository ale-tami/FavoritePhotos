//
//  JSONManager.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "JSONManager.h"

#define urlFlikr "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&license=1,2,3&per_page=10&has_geo=1&extras=url_z,geo,owner_name&tag_mode=all&tags="


@interface JSONManager ()

@property NSMutableArray *imagesArray;

@end

@implementation JSONManager

static JSONManager *jsonManager = nil;


+ (instancetype) getInstance
{
    if (jsonManager) {
        return jsonManager;
    } else {
        jsonManager.imagesArray = [NSMutableArray array];
        return jsonManager = [JSONManager new];
    }
}

// 97a3c9363a4a20b9 secret

- (void)makeRequestWithCriteria:(NSString *)criteria
{
    // to be refactored, make it generic
    __block NSDictionary * responseJSON = [[NSDictionary alloc] init];
    
    if (!criteria) {
        criteria = @"OMG";
    }
    
    NSString *completeURL = [[NSString stringWithFormat:@urlFlikr] stringByAppendingString:criteria];
    
    NSString *stringURL = completeURL;
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.delegate responseWithJSON:responseJSON];
      
    
    }];
    
}

- (void) makeRequestOfImagesWithAmount: (NSUInteger)amount fromArray: (NSArray *)array
{
    self.imagesArray = nil;
    self.imagesArray = [NSMutableArray array];
    // to be refactored, make it generic
    
    if (!amount) {
        amount = 10;
    } else if ( amount > array.count) {
        amount = array.count;
    }

    for (int i = 0; i < amount; i++) {
        
        NSString *completeURL = [[array objectAtIndex:i]  objectForKey:@"url_z"];
        
        NSString *stringURL = completeURL;
        
        NSURL *url = [NSURL URLWithString:stringURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            UIImage * image = [UIImage imageWithData:data];
            
            if (i == (amount - 1)) {
                [self createArrayUntilIsOver:YES withImage:image];
            } else {
                [self createArrayUntilIsOver:NO withImage:image];
            }
            
        }];
    }
    
}

- (void) createArrayUntilIsOver:(BOOL) isOver withImage:(UIImage*) image
{
    if (!isOver) {
        [self.imagesArray addObject:image];
    } else {
        [self.imagesArray addObject:image];
        [self.delegate responseWithArrayOfImages:self.imagesArray];
    }
}


- (void) responseWithJSON:(NSDictionary *) json
{
    
}

- (void) responseWithArrayOfImages:(NSArray *) images
{
    
}



@end
