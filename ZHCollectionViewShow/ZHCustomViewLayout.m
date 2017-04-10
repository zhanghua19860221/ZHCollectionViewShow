//
//  ZHCustomViewLayout.m
//  ZHCollectionViewLayout
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import "ZHCustomViewLayout.h"

@implementation ZHCustomViewLayout
/**
 初始化布局
 
 */
- (void)prepareLayout
{
    [super prepareLayout];
    [self setupLayout];
}
- (void)setupLayout
{
    
    //   CGFloat inset  = self.collectionView.bounds.size.width * (6/64.0f);
    //   inset = floor(inset);
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width/3.0,self.collectionView.frame.size.width/3.0);
    //   self.sectionInset = UIEdgeInsetsMake(0,inset, 0,inset);
    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}
/**
 给每个item做个性化设置的。
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获得super已经计算好的布局属性
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
//    NSLog(@"%lu++++++++", (unsigned long)attributes.count);
    
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in attributes) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        // 根据间距值 计算 cell的缩放比例
        CGFloat scale = 1.0 - delta / self.collectionView.frame.size.width;
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attributes;
}
/**
 允许item的实时刷新
 
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}
/**
 滚动停止时，滚动慢慢停止并停留在某一个item上的效果
 
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算最终显示的矩形框
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    //获取最终显示在矩形框中的元素的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
        
    //获取UICollectionView的中点，以contentView的左上角为原点
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //获取所有元素到中点的最短距离
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attribute in array)
    {
        CGFloat delta = attribute.center.x - centerX;
        if (ABS(minDelta) > ABS(delta))
        {
            minDelta = delta;
        }
    }
    //改变UICollectionView的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}
@end
