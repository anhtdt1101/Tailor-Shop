//
//  UIToolbarKeyboard.m
//  BIDCBank
//
//  Created by ChungNV on 9/10/15.
//  Copyright (c) 2015 Pham Tuan. All rights reserved.
//

#import "UIToolbarKeyboard.h"
#import "SDKTemplateCommonDefines.h"

@implementation UIToolbarKeyboard

+(UIToolbarKeyboard *)create
{
    UIToolbarKeyboard *toolbar = [[UIToolbarKeyboard alloc] init];
    toolbar.frame = CGRectMake(0, 0, screenWidth, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    toolbar.vBtPrev = [[UIBarButtonItem alloc] initWithImage:[self Icon_backButton] style:UIBarButtonItemStylePlain target:toolbar action:@selector(didSelectButtonPrev)];
    //[[UIBarButtonItem alloc] initWithTitle:@"Previous".localizable style:UIBarButtonItemStyleBordered target:toolbar action:@selector(didSelectButtonPrev)];
    toolbar.vBtNext = [[UIBarButtonItem alloc] initWithImage:[self Icon_forwardButton] style:UIBarButtonItemStylePlain target:toolbar action:@selector(didSelectButtonNext)];
    //[[UIBarButtonItem alloc] initWithTitle:@"Next".localizable style:UIBarButtonItemStyleBordered target:toolbar action:@selector(didSelectButtonNext)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = 16;
    
    toolbar.vBtDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:toolbar action:@selector(didSelectButtonDone)];
    
    NSArray *barButtonItems = @[toolbar.vBtPrev, space, toolbar.vBtNext, flexBarButton, toolbar.vBtDone];
    toolbar.items = barButtonItems;
    
    return toolbar;
}
-(void) didSelectButtonPrev
{
    if (_prevAction) {
        _prevAction();
    }
}
-(void) didSelectButtonNext
{
    if (_nextAction) {
        _nextAction();
    }
}
-(void) didSelectButtonDone
{
    if (_doneOtherAction) {
        _doneOtherAction();
    }
    if (_doneAction) {
        _doneAction();
    }
}
#pragma mark - helper

+ (UIImage *)Icon_backButton
{
    UIImage *backButtonImage = nil;
    UIGraphicsBeginImageContextWithOptions((CGSize){12,21}, NO, [[UIScreen mainScreen] scale]);
    {
        //// Color Declarations
        UIColor* backColor = [UIColor blackColor];
        
        //// BackButton Drawing
        UIBezierPath* backButtonPath = [UIBezierPath bezierPath];
        [backButtonPath moveToPoint: CGPointMake(10.9, 0)];
        [backButtonPath addLineToPoint: CGPointMake(12, 1.1)];
        [backButtonPath addLineToPoint: CGPointMake(1.1, 11.75)];
        [backButtonPath addLineToPoint: CGPointMake(0, 10.7)];
        [backButtonPath addLineToPoint: CGPointMake(10.9, 0)];
        [backButtonPath closePath];
        [backButtonPath moveToPoint: CGPointMake(11.98, 19.9)];
        [backButtonPath addLineToPoint: CGPointMake(10.88, 21)];
        [backButtonPath addLineToPoint: CGPointMake(0.54, 11.21)];
        [backButtonPath addLineToPoint: CGPointMake(1.64, 10.11)];
        [backButtonPath addLineToPoint: CGPointMake(11.98, 19.9)];
        [backButtonPath closePath];
        [backColor setFill];
        [backButtonPath fill];
        
        backButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return backButtonImage;
}

+ (UIImage *)Icon_forwardButton
{
    UIImage *forwardButtonImage = nil;
    UIGraphicsBeginImageContextWithOptions((CGSize){12,21}, NO, [[UIScreen mainScreen] scale]);
    {
        //// Color Declarations
        UIColor* forwardColor = [UIColor blackColor];
        
        //// BackButton Drawing
        UIBezierPath* forwardButtonPath = [UIBezierPath bezierPath];
        [forwardButtonPath moveToPoint: CGPointMake(1.1, 0)];
        [forwardButtonPath addLineToPoint: CGPointMake(0, 1.1)];
        [forwardButtonPath addLineToPoint: CGPointMake(10.9, 11.75)];
        [forwardButtonPath addLineToPoint: CGPointMake(12, 10.7)];
        [forwardButtonPath addLineToPoint: CGPointMake(1.1, 0)];
        [forwardButtonPath closePath];
        [forwardButtonPath moveToPoint: CGPointMake(0.02, 19.9)];
        [forwardButtonPath addLineToPoint: CGPointMake(1.12, 21)];
        [forwardButtonPath addLineToPoint: CGPointMake(11.46, 11.21)];
        [forwardButtonPath addLineToPoint: CGPointMake(10.36, 10.11)];
        [forwardButtonPath addLineToPoint: CGPointMake(0.02, 19.9)];
        [forwardButtonPath closePath];
        [forwardColor setFill];
        [forwardButtonPath fill];
        
        forwardButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return forwardButtonImage;
}

@end
