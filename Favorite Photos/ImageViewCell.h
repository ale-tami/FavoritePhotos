//
//  ImageViewCell.h
//  Favorite Photos
//
//  Created by Alejandro Tami on 11/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;


@end
