#import <UIKit/UIKit.h>
#import "CirclePopup.h"
#import <objc/runtime.h>

@implementation UIViewController (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [UIViewController class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzled_viewDidAppear:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)swizzled_viewDidAppear:(BOOL)animated {
    [self swizzled_viewDidAppear:animated]; // calls original viewDidAppear

    // Install overlay only once
    [CirclePopup installOverlayIfNeeded:self];
}

@end
