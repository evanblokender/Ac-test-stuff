#import "CirclePopup.h"
#import <objc/runtime.h>

static BOOL installed = NO;

@implementation CirclePopup

+ (void)installOverlayIfNeeded:(UIViewController*)vc {
    if (installed) return;
    installed = YES;

    UIView *rootView = vc.view;
    if (!rootView) return;

    // Create circle
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 80, 80)];
    circle.backgroundColor = [UIColor systemBlueColor];
    circle.layer.cornerRadius = 40;
    circle.clipsToBounds = YES;

    // Drag gesture
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [circle addGestureRecognizer:pan];

    // Tap gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    [circle addGestureRecognizer:tap];

    [rootView addSubview:circle];
    [rootView bringSubviewToFront:circle];

    objc_setAssociatedObject(self, @"circleView", circle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)handlePan:(UIPanGestureRecognizer *)pan {
    UIView *view = pan.view;
    CGPoint translation = [pan translationInView:view.superview];
    view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:view.superview];
}

+ (void)circleTapped {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIView *rootView = vc.view;

    UIView *popup = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 220, 140)];
    popup.backgroundColor = [UIColor whiteColor];
    popup.layer.cornerRadius = 12;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 220, 30)];
    label.text = @"Test";
    label.textAlignment = NSTextAlignmentCenter;
    [popup addSubview:label];

    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 220, 20)];
    footer.text = @"Created by EvanBlokEnder";
    footer.font = [UIFont systemFontOfSize:10];
    footer.textAlignment = NSTextAlignmentCenter;
    [popup addSubview:footer];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
    close.frame = CGRectMake(200, 10, 20, 20);
    [close setTitle:@"X" forState:UIControlStateNormal];
    [close addTarget:popup action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [popup addSubview:close];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [popup addGestureRecognizer:pan];

    [rootView addSubview:popup];
    [rootView bringSubviewToFront:popup];
}

@end
