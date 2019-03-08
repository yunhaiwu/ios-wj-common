//
//  RootViewController.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/5/23.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, copy) NSArray *dataSources;
@end

@implementation RootViewController

-(void)wjvcInit {
    [super wjVcInit];
    self.dataSources = @[
  @{@"title":@"CollectionView Demo",@"target":@"CollectionViewDemo"},
  @{@"title":@"WJActiveSheet Demo",@"target":@"WJActiveSheetDemo"},
  @{@"title":@"WJAlertView Demo",@"target":@"WJAlertViewDemo"},
  @{@"title":@"WJLineView Demo",@"target":@"WJLineViewController"},
  @{@"title":@"WJVerticalButton Demo",@"target":@"WJButtonViewController"}];
    
    
}

#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *d = _dataSources[indexPath.row];
    NSString *target = d[@"target"];
    Class targetClazz = NSClassFromString(target);
    BaseWJViewController *vc = [targetClazz wjInstance];
    [vc setWjNavTitle:d[@"title"]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSources count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellId = @"kCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    NSDictionary *d = _dataSources[indexPath.row];
    [[cell textLabel] setText:d[@"title"]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.wjNavTitle = @"WJCommon Demos";
}

-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

-(BOOL)wjexistNavigationBar {
    return YES;
}

@end
