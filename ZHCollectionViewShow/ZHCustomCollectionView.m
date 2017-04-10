//
//  ZHCustomCollectionView.m
//  ZHCollectionViewShow
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import "ZHCustomCollectionView.h"
#import "ZHCollectionViewCell.h"
#import "ZHCustomViewLayout.h"

@implementation ZHCustomCollectionView
{
    UIButton * leftButton;
    UIButton * rightButton;
    NSTimer  * timer;
}
- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isClick = YES;
        [self creatData];
        [self creatCollectionView];
    }
    return self;
}
/**
 初始化数据
 
 */
-(void)creatData{
    
    self.imageArray = [[NSArray alloc]initWithObjects:@"1@2x.png",@"2@2x.png",@"3@2x.png",@"4@2x.png",@"5@2x.png",@"6@2x.png",@"7@2x.png",@"8@2x.png",@"9@2x.png", nil];
    self.textArray = [NSArray arrayWithObjects:@"“翡，你墨属”高级定制系列",@"K金镶钻墨翠套件",@"钻哈哈哈翠",@"K金镶钻黄翠套件",@"K金镶钻黑翠套件",@"K金镶钻哈哈哈翠套件",@"哈哈翠套件",@"K金镶套件",@"K金镶套件", nil];
    self.piceArray = [NSArray arrayWithObjects:@"￥55,800,00",@"￥55,800",@"￥5,800,00",@"￥55,800,00",@"55,800",@"￥55,800,00",@"￥55,800,00",@"￥55,800,00",@"￥55,800,00",nil];
}
/**
 创建collectionView
 
 */
-(void)creatCollectionView{
    
    ZHCustomViewLayout *Layout = [[ZHCustomViewLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(120, 0, self.frame.size.width-241, 360) collectionViewLayout:Layout];
    Layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self;
    // 垂直滚动时设置行间距
//    Layout.minimumInteritemSpacing = 0;
    //水平滚动时设置例间距
    Layout.minimumLineSpacing = 0;
    // 开启分页
    // self.collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[ZHCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:self.collectionView];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(30,150, 60, 60);
    [leftButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.hidden = YES ;
    [self addSubview:leftButton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SC_WIDTH-90,150, 60, 60);
    [rightButton setImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(0, 370, SC_WIDTH, 40);
    self.nameLabel.text  = self.textArray[0];
    self.nameLabel.font  = [UIFont systemFontOfSize:14];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    self.piceLabel = [[UILabel alloc]init];
    self.piceLabel.frame = CGRectMake(0, 420, SC_WIDTH, 40);
    self.piceLabel.text  = self.piceArray[0];
    self.piceLabel.font = [UIFont systemFontOfSize:18];
    [self.piceLabel setTextColor:[UIColor yellowColor]];
    self.piceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.piceLabel];
    
}
- (void)leftClick:(UIButton *)btn
{
    float offset = self.collectionView.frame.size.width/3.0;
    
    if (self.collectionView.contentOffset.x<= offset) {
        
        leftButton.hidden = YES;
    }
    rightButton.hidden = NO;
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(leftSomething:) object:btn];
    [self performSelector:@selector(leftSomething:) withObject:btn afterDelay:0.2f];
}
- (void)leftSomething:(id)sender
{
    CGFloat xx = (self.frame.size.width-241)/3.0;
    [_collectionView setContentOffset:CGPointMake(self.currentOffset-xx,0) animated:YES];
   
    int index = self.collectionView.contentOffset.x /((self.frame.size.width-241)/3.0);
    self.nameLabel.text  = self.textArray[index];
    self.piceLabel.text  = self.piceArray[index];
}
- (void)rightClick:(UIButton *)btn
{

    float offset = self.collectionView.frame.size.width/3.0*(self.imageArray.count-2);
    if (self.collectionView.contentOffset.x >= offset) {
        
        rightButton.hidden = YES;
    }
    leftButton.hidden = NO;
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(rightSomething:) object:btn];
    [self performSelector:@selector(rightSomething:) withObject:btn afterDelay:0.2f];
}
- (void)rightSomething:(id)sender
{
    
    CGFloat xx = (self.frame.size.width-241)/3.0;
    [_collectionView setContentOffset:CGPointMake(self.currentOffset+xx,0) animated:YES];
   
    int index = self.collectionView.contentOffset.x /((self.frame.size.width-241)/3.0);
    self.nameLabel.text  = self.textArray[index];
    self.piceLabel.text  = self.piceArray[index];
}

/**
 只要滚动都会触发此方法

 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"开始滚动");
    self.currentOffset = scrollView.contentOffset.x;
}

/**
 非触摸滚动结束时 执行此方法

 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    
    int index = self.collectionView.contentOffset.x /((self.frame.size.width-241)/3.0);
    self.nameLabel.text  = self.textArray[index];
    self.piceLabel.text  = self.piceArray[index];
}

/**
 触摸滚动开始时触发此方法

 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    NSLog(@"开始触摸滚动");
    
}

/**
 触摸滚动结束时触发此方法

 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"结束触摸滚动");
    int index = self.collectionView.contentOffset.x /((self.frame.size.width-241)/3.0);
    self.nameLabel.text  = self.textArray[index];
    self.piceLabel.text  = self.piceArray[index];
}

/**
 @return 返回有多少个分组
 
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
/**
 @return 返回每个组有多少个item
 
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count;
}
/**
 @return 返回每个item
 
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL"forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZHCollectionViewCell alloc]init];
    }
    [cell addDataSourceToCell:self.imageArray[indexPath.row]];
    return cell;
}
///**
// @return 每个item的大小

// */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.frame.size.width-241)/3.0,(self.frame.size.width-241)/3.0);
}
/**
 item的点击事件
 
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你选中了第 %ld 个item",(long)indexPath.row);
}
/**
 @return 返回item的内边距
 
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,(self.frame.size.width-241)/3.0, 0,(self.frame.size.width-241)/3.0);
}
/**
 选着第几个item不可以被选中，触发事件
 */
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 2) {
    //        return NO;
    //    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
