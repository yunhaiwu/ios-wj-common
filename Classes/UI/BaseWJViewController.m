//
//  BaseWJViewController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJViewController.h"
#import "BaseWJNavigationBar.h"

NSString * const WJViewControllerTitleKey = @"WJViewControllerTitleKey";


@interface BaseWJViewController ()<IWJLoadingViewDelegate>
@property (nonatomic, assign) BOOL wjInitTag;
@end

@implementation BaseWJViewController

-(BOOL)wjExistNavigationBar {
    return YES;
}

#pragma mark custom
-(NSArray*)wjViewModels {
    return nil;
}

#pragma mark IWJLoadingViewDelegate
-(void)loadingRefresh:(UIView<IWJLoadingView> *)loadingView {
    [loadingView setState:WJLoadingStateLoading];
    [self performSelectorOnMainThread:@selector(wjExecLoadDataAction) withObject:nil waitUntilDone:NO];
}
#pragma mark ViewController Overriding
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSArray *viewModels = [self wjViewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm setWjActive:NO];
        [vm wjViewWillDisappear];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSArray *viewModels = [self wjViewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wjViewDidDisappear];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController) {
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    NSArray *viewModels = [self wjViewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm setWjActive:YES];
        [vm wjViewWillAppear];
    }
    if (_wjLoadingView) [self.view bringSubviewToFront:_wjLoadingView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *viewModels = [self wjViewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wjViewDidAppear];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
#endif
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        //解决iOS7之后滚动视图留有间隙问题
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
#endif
    }
    
    [self wjRefreshUIElement];
    
    //添加加载视图
    if (!_wjLoadingView) {
        UIView<IWJLoadingView> *v = [self wjInstanceLoadingView];
        if (v) {
            [v setDelegate:self];
            [v setOffsetY:-20.0f];
            [self.wjView addSubview:v];
            __weak typeof(self) selfObject = self;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(selfObject.wjView);
            }];
            _wjLoadingView = v;
        }
    }
    
    [self loadingRefresh:_wjLoadingView];
}

#pragma mark NavigationBar style
-(void)setWjNavTitle:(NSString *)wjNavTitle {
    if (_wjNavTitle == wjNavTitle) {
        return;
    }
    _wjNavTitle = [wjNavTitle copy];
    [_wjNavigationItem setTitle:_wjNavTitle];
}


-(void) wjPopExec:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

-(void) wjRefreshUIElement {
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if ([self wjExistNavigationBar]) {
        __weak typeof(self) selfObject = self;
        if (!_wjNavigationBar) {
            BaseWJNavigationBar *bar = [[BaseWJNavigationBar alloc] init];
            UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.wjNavTitle];
            _wjNavigationItem = item;
            
            [bar setItems:[NSArray arrayWithObjects:item, nil]];
            
            if ([self.navigationController.viewControllers count] > 1) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
                UIImage *icon = [UIImage imageNamed:@"wj-nav-icon-back"];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(wjPopExec:)];
                [self.wjNavigationItem setLeftBarButtonItem:backItem];
#else
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
                negativeSpacer.width = -2.0f;
                UIImage *icon = [UIImage imageNamed:@"wj-nav-icon-back"];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(wjPopExec:)];
                [self.wjNavigationItem setLeftBarButtonItems:@[negativeSpacer,backItem]];
#endif
            }
            [self.view addSubview:bar];
            [bar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selfObject.view.mas_left);
                make.right.equalTo(selfObject.view.mas_right);
                make.top.equalTo(selfObject.view.mas_top);
                make.height.equalTo(@(statusHeight+44.0f));
            }];
            _wjNavigationBar = bar;
        }
        if (!_wjView) {
//            UIView *v = [[UIView alloc] initWithFrame:([self edgesForExtendedLayout] & UIRectEdgeTop) ? self.view.bounds : CGRectMake(0, 64.0f, self.view.bounds.size.width, self.view.bounds.size.height - 64.0f)];
            UIView *v = [[UIView alloc] init];
            [self.view insertSubview:v atIndex:0];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake(([selfObject edgesForExtendedLayout] & UIRectEdgeTop) ? 0 : statusHeight+44.0f, 0, 0, 0);
                make.edges.equalTo(selfObject.view).with.insets(edgeInsets);
            }];
            _wjView = v;
        } else {
            if (self.wjViewTopLayoutConstraint) {
                [self.wjViewTopLayoutConstraint setConstant:statusHeight+44.0f];
            } else {
                NSArray *constraints = [self.view constraints];
                for (NSLayoutConstraint *constraint in constraints) {
                    if ([constraint constant] == 64.0f) {
                        [constraint setConstant:statusHeight+44.0f];
                        break;
                    }
                }
            }
        }
    } else {
        _wjView = self.view;
    }
}

//-(void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    if ([self wjExistNavigationBar]) {
//        [_wjNavigationBar setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64.0f)];
//        if ([self edgesForExtendedLayout] & UIRectEdgeTop) {
//            [_wjView setFrame:self.view.bounds];
//        } else {
//            [_wjView setFrame:CGRectMake(0, 64.0f, self.view.bounds.size.width, self.view.bounds.size.height - 64.0f)];
//        }
//    }
//}

-(void)dealloc {
    [self wjUnregisterFromKVO];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
#endif
    
    NSArray *viewModels = [self wjViewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wjDidReceiveMemoryWarning];
    }
    
}

-(instancetype)init {
    self = [super init];
    if (self) {
        if (!_wjInitTag) {
            [self wjVcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (!_wjInitTag) {
            [self wjVcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!_wjInitTag) {
            [self wjVcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(void)wjVcInit {
    [self wjRegisterForKVO];
}


#pragma mark exec action method
-(void) wjExecLoadDataAction {}

#pragma mark instance
+(instancetype)wjInstance {
    BaseWJViewController *viewController = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFilePath] || [fm fileExistsAtPath:nibFilePath] || [fm fileExistsAtPath:ipadNibFilePath]) {
            viewController = [[self alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
        } else {
            viewController = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        viewController = [[self alloc] init];
    }
    return viewController;
}

#pragma mark Instance LoadingView
-(UIView<IWJLoadingView> *)wjInstanceLoadingView {
    return nil;
}


#pragma mark KVO
-(NSKeyValueObservingOptions) observerOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}
-(void) wjRegisterForKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    for (NSString *keypath in keypaths) {
        [self addObserver:self forKeyPath:keypath options:[self observerOptionsForKeypath:keypath] context:NULL];
    }
}
-(void) wjUnregisterFromKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    for (NSString *keypath in keypaths) {
        [self removeObserver:self forKeyPath:keypath];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self wjChangeForKeypath:keyPath change:change];
}

-(NSArray*)wjObservableKeypaths {
    return nil;
}

-(void)wjChangeForKeypath:(NSString *)keyPath change:(NSDictionary *)change {}




#pragma mark InterfaceOrientations

-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
