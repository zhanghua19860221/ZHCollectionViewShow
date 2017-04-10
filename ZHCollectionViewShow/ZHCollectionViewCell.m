//
//  ZHCollectionViewCell.m
//  ZHCollectionViewLayout
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.

#import "ZHCollectionViewCell.h"

@implementation ZHCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configCell];
    }
    return self;
}

-(void)configCell{
    
    self.layer.borderColor=[UIColor whiteColor].CGColor;
    self.layer.borderWidth= 1.5;
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    [self.contentView addSubview:self.imageView];
    self.contentView.backgroundColor = [UIColor orangeColor];
}
-(void)addDataSourceToCell:(NSString*)imageName{
    
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}
@end
