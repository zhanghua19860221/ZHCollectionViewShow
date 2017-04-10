//
//  ZHCollectionViewCell.h
//  ZHCollectionViewLayout
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHCollectionViewCell : UICollectionViewCell
@property (strong ,nonatomic) UIImageView * imageView;
-(void)addDataSourceToCell:(NSString*)imageName;

@end
