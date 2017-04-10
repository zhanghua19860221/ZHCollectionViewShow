//
//  ZHCustomCollectionView.h
//  ZHCollectionViewShow
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHCustomCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong ,nonatomic) UICollectionView *collectionView;
@property (strong ,nonatomic) NSArray *imageArray;
@property(nonatomic ,assign)float        currentOffset;//记录scrollView当前的偏移量
@property(nonatomic ,strong)UILabel      *nameLabel    ;//产品名称文本
@property(nonatomic ,strong)NSArray      *textArray    ;//产品名称数组
@property(nonatomic ,strong)UILabel      *piceLabel    ;//产品价格文本
@property(nonatomic ,strong)NSArray      *piceArray    ;//产品价格数组
@property(nonatomic ,assign)BOOL          isClick      ;//是否可点击


- (id)initWithFrame:(CGRect)frame;
@end
