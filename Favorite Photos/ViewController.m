//
//  ViewController.m
//  Favorite Photos
//
//  Created by Alejandro Tami on 11/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "JSONManager.h"
#import "ImageViewCell.h"
#import "PlistManager.h"

@interface ViewController () <JSONManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSArray *photos;
@property NSArray *favoritedImages;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [JSONManager getInstance].delegate = self;
    [[JSONManager getInstance] makeRequestWithCriteria:@"lion"];
    
    self.searchBar.delegate = self;
    
    self.photos = [NSArray new];
    
    self.favoritedImages = [[PlistManager getInstance] deserializeFavoriteImages];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [[JSONManager getInstance] makeRequestWithCriteria:searchBar.text];
    [searchBar resignFirstResponder];

}

#pragma mark delegate JSONmanager

- (void)responseWithJSON:(NSDictionary *)json
{
    [[JSONManager getInstance] makeRequestOfImagesWithAmount:10 fromArray:[[json objectForKey:@"photos"] objectForKey:@"photo" ]];
}

- (void)responseWithArrayOfImages:(NSArray *)images
{
    self.photos = images;
    [self.collectionView reloadData];
}

#pragma mark delegates collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCell *cell = (ImageViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.switchView.isHidden) {
        cell.switchView.on = YES;
        cell.switchView.hidden = NO;
        [[PlistManager getInstance] serializeFavoriteImage:cell.imageView.image];
        self.favoritedImages = [[PlistManager getInstance] deserializeFavoriteImages];
    } else {
        
    }


}

#pragma mark datasource collection

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if ([self.favoritedImages containsObject:[self.photos objectAtIndex:indexPath.row]]) {
        cell.switchView.on = YES;
        cell.switchView.hidden = NO;
    } else {
        cell.switchView.on = NO;
        cell.switchView.hidden = YES;
    }
    
    cell.imageView.image = [self.photos objectAtIndex:indexPath.row];
    
    return cell;
}


@end
