//
//  ViewController.m
//  ScrollPage
//
//  Created by Mac on 16/9/13.
//  Copyright © 2016年 LoveSpending. All rights reserved.
//

#import "ViewController.h"
#import "NSString.h"
#import "MJRefresh.h"

@interface ViewController ()<UIScrollViewDelegate>{

    UITableView *tableOne;
    UITableView *tableTwo;
    UITableView *tableThree;
    UITableView *tableFour;
    NSTimer *timer;
}

@property(nonatomic,strong) UIView *categoryBack;
@property(nonatomic,strong) UIButton *categoryBt;
@property(nonatomic,strong) UIView *categoryLine;

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self categoryView];
}

//分类
- (void)categoryView{
    
    self.dataArray = @[@"一",@"二",@"三",@"四"];
    
    //按钮背景
    self.categoryBack = [[UIView alloc] initWithFrame:(CGRectMake(0, 20, s_v_width, 40))];
    self.categoryBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.categoryBack];
    
    UIView *cateLine = [[UIView alloc] initWithFrame:(CGRectMake(0, 39, s_v_width, 1))];
    cateLine.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.categoryBack addSubview:cateLine];
    
    for (int i=0; i<self.dataArray.count; i++) {
        
        self.categoryBt = [[UIButton alloc] init];
        self.categoryBt.frame = CGRectMake(s_v_width/4*i, 0, s_v_width/4, CGRectGetHeight(self.categoryBack.frame));
        
        [self.categoryBt setTitle:[self.dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [self.categoryBt setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
        [self.categoryBt addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        self.categoryBt.tag = 100 + i;
        self.categoryBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.categoryBack addSubview:self.categoryBt];
        
    }
    
    //下划线
    self.categoryLine = [[UIView alloc] initWithFrame:(CGRectMake(s_v_width/20, CGRectGetHeight(self.categoryBt.frame)-2, s_v_width*2/13, 2))];
    self.categoryLine.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [self.categoryBack addSubview:self.categoryLine];
    
    UIView *white = [[UIView alloc] initWithFrame:(CGRect){0,0,10,10}];
    [self.view addSubview:white];
    
    //背景
    self.scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.categoryBack.frame), s_v_width, s_v_height-CGRectGetMaxY(self.categoryBack.frame)))];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(s_v_width*4, s_v_height-CGRectGetMaxY(self.categoryBack.frame));
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //scrollView上视图
    tableOne = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, s_v_width, s_v_height-CGRectGetMaxY(self.categoryBack.frame)))];
    tableOne.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.5 alpha:0.3];
    tableOne.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [tableOne.mj_header beginRefreshing];
        
        timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        
    }];
    [self.scrollView addSubview:tableOne];
    
    tableTwo = [[UITableView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(tableOne.frame), CGRectGetMinY(tableOne.frame), CGRectGetWidth(tableOne.frame), CGRectGetHeight(tableOne.frame)))];
    tableTwo.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.2 alpha:0.3];
    tableTwo.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [tableTwo.mj_header beginRefreshing];
        
        timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        
    }];
    [self.scrollView addSubview:tableTwo];
    
    tableThree = [[UITableView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(tableTwo.frame), CGRectGetMinY(tableOne.frame), CGRectGetWidth(tableOne.frame), CGRectGetHeight(tableOne.frame)))];
    tableThree.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.2 alpha:0.3];
    tableThree.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [tableThree.mj_header beginRefreshing];
        
        timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        
    }];
    [self.scrollView addSubview:tableThree];
    
    tableFour = [[UITableView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(tableThree.frame), CGRectGetMinY(tableOne.frame), CGRectGetWidth(tableOne.frame), CGRectGetHeight(tableOne.frame)))];
    tableFour.backgroundColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.7 alpha:0.3];
    tableFour.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [tableFour.mj_header beginRefreshing];
        
        timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        
    }];
    [self.scrollView addSubview:tableFour];
    
    
}

//每个table刷新（不用table可省略）
- (void)timerAction:(NSTimer *)sender{
    
    [tableOne reloadData];
    [tableTwo reloadData];
    [tableThree reloadData];
    [tableFour reloadData];
    
    [tableOne.mj_header endRefreshing];
    [tableTwo.mj_header endRefreshing];
    [tableThree.mj_header endRefreshing];
    [tableFour.mj_header endRefreshing];
    
    [timer invalidate];
    
}

//分类按钮点击
- (void)categoryAction:(UIButton*)sender{
    
    for (UIButton *bt in self.categoryBack.subviews) {
        
        if (bt.tag>=100) {
            
            if (bt.tag == sender.tag) {
                bt.selected = YES;
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.categoryLine.frame = CGRectMake(s_v_width/20+s_v_width/4*(bt.tag-100),CGRectGetHeight(self.categoryBt.frame)-2, s_v_width*2/13, 2);
                    
                    self.scrollView.contentOffset = CGPointMake(s_v_width*((long)bt.tag-100), 0);

                }];

                
            } else {
                bt.selected = NO;
                bt.userInteractionEnabled = YES;
            }
        }
    }
    
}

//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int pageNum = scrollView.contentOffset.x/CGRectGetWidth(self.scrollView.frame);
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.categoryLine.frame = CGRectMake(s_v_width/20+s_v_width/4*pageNum,CGRectGetHeight(self.categoryBt.frame)-2, s_v_width*2/13, 2);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
