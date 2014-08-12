//
//  FavoritesViewController.m
//  Favorite Photos
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "FavoritesViewController.h"
#import "PlistManager.h"
#import "ImageViewCell.h"

@interface FavoritesViewController ()

@property NSArray *favoriteImages;

@end

@implementation FavoritesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.favoriteImages = [[PlistManager getInstance] deserializeFavoriteImages];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favoriteImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageView.image = [self.favoriteImages objectAtIndex:indexPath.row];
    
    return cell;
}

@end
