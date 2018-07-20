//
//  CollectionViewDemo.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/5/23.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "CollectionViewDemo.h"

@interface CustomCollectionItemView : UICollectionViewCell

@property (nonatomic, weak) UILabel *refLab;

@end

@implementation CustomCollectionItemView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (!_refLab) {
            UILabel *label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
            [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor redColor]];
            [self.contentView addSubview:label];
            _refLab = label;
        }
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_refLab setFrame:self.contentView.bounds];
}

@end



@interface CollectionViewDemo ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *refCollectionView;

@property (nonatomic, weak) NSTimer *refTimer;
@end


@implementation CollectionViewDemo

#pragma mark UICollectionViewDataSource
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger number = (int)100000;
    return number;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCellId" forIndexPath:indexPath];
    [[cell refLab] setText:[NSString stringWithFormat:@"%li,%li",indexPath.section, indexPath.row]];
    if (indexPath.row % 2) {
        [[cell contentView] setBackgroundColor:[UIColor grayColor]];
    } else {
        [[cell contentView] setBackgroundColor:[UIColor greenColor]];
    }
    return cell;
}

#pragma mark UICollectionViewDelegate
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始拖动，取消定时器
    NSLog(@"scrollViewWillBeginDragging:");
    [self closeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //结束拖动
    NSLog(@"scrollViewDidEndDragging:willDecelerate:");
    [self setupTimer];
}

-(void) setupTimer {
    if (!_refTimer && ![self.refCollectionView isDragging]) {
        _refTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerExec:) userInfo:nil repeats:YES];
    }
}

-(void) timerExec:(NSTimer*) timer {
    if ([NSThread isMainThread]) {
        NSLog(@"main");
    } else {
        NSLog(@"non main");
    }
    NSIndexPath *indexPath = [self.refCollectionView indexPathForItemAtPoint:CGPointMake(self.refCollectionView.contentOffset.x + self.refCollectionView.bounds.size.width/2, self.refCollectionView.bounds.size.height/2)];
    [self.refCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

-(void) closeTimer {
    if ([_refTimer isValid]) {
        [_refTimer invalidate];
        _refTimer = nil;
    }
}

-(void)dealloc {
    [self closeTimer];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.wjNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(leftExec:)];
    
    if (!_refCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGSize size = CGSizeMake(self.wjView.bounds.size.width, 100);
        [flowLayout setItemSize:size];
        [flowLayout setMinimumLineSpacing:0];
        [flowLayout setMinimumInteritemSpacing:0];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.wjView.bounds.size.width, 100) collectionViewLayout:flowLayout];
        [collectionView setPagingEnabled:YES];
        [collectionView setBackgroundColor:[UIColor clearColor]];
        [collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
        [self.wjView addSubview:collectionView];
        _refCollectionView = collectionView;
        [collectionView setDelegate:self];
        [collectionView setDataSource:self];
        
        [self.refCollectionView registerClass:[CustomCollectionItemView class] forCellWithReuseIdentifier:@"customCellId"];
//        [self.refCollectionView reloadData];
    }
    
    [self.refCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:100000/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self setupTimer];
}

-(void) leftExec:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
