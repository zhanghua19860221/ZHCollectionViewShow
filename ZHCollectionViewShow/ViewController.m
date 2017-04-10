//
//  ViewController.m
//  ZHCollectionViewShow
//
//  Created by zhanghua0221 on 17/2/15.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import "ViewController.h"
#import "ZHCustomCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)creatView{
    
    ZHCustomCollectionView *view = [[ZHCustomCollectionView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 568)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
