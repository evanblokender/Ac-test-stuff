#import "CirclePopup.h"
#import <objc/runtime.h>

@implementation CirclePopup

+ (void)loadLibrary:(UIWindow *)mainWindow {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *circleWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
        circleWindow.backgroundColor = [UIColor clearColor];
        circleWindow.windowLevel = UIWindowLevelAlert + 1;
        circleWindow.hidden = NO;

        UIView *circle = [[UIView alloc] initWithFrame:circleWindow.bounds];
        circle.backgroundColor = [UIColor systemBlueColor];
        circle.layer.cornerRadius = 40;
        circle.clipsToBounds = YES;
        [circleWindow addSubview:circle];

        // Drag gesture
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [circle addGestureRecognizer:pan];

        // Tap gesture
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
        [circle addGestureRecognizer:tap];

        objc_setAssociatedObject(self, @"circleWindow", circleWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
}

+ (void)handlePan:(UIPanGestureRecognizer *)pan {
    UIView *view = pan.view;
    CGPoint translation = [pan translationInView:view.superview];
    view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:view.superview];
}

+ (void)circleTapped {
    UIWindow *popup = [[UIWindow alloc] initWithFrame:CGRectMake(150, 200, 200, 150)];
    popup.backgroundColor = [UIColor whiteColor];
    popup.layer.cornerRadius = 12;
    popup.windowLevel = UIWindowLevelAlert + 2;
    popup.hidden = NO;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 30)];
    label.text = @"Test";
    label.textAlignment = NSTextAlignmentCenter;
    [popup addSubview:label];

    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 200, 20)];
    footer.text = @"Created by EvanBlokEnder";
    footer.font = [UIFont systemFontOfSize:10];
    footer.textAlignment = NSTextAlignmentCenter;
    [popup addSubview:footer];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
    close.frame = CGRectMake(170, 10, 20, 20);
    [close setTitle:@"X" forState:UIControlStateNormal];
    [close addTarget:popup action:@selector(setHidden:) forControlEvents:UIControlEventTouchUpInside];
    [popup addSubview:close];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopupPan:)];
    [popup addGestureRecognizer:pan];

    objc_setAssociatedObject(self, @"popupWindow", popup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)handlePopupPan:(UIPanGestureRecognizer *)pan {
    UIView *popup = pan.view;
    CGPoint translation = [pan translationInView:popup.superview];
    popup.center = CGPointMake(popup.center.x + translation.x, popup.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:popup.superview];
}

@end
