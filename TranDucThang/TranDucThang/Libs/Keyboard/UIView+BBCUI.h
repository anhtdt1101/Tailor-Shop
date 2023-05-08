//
//  UIView+BBCUI.h
//  VnPayTicketSDKV2
//
//  Created by PhamTuan on 9/15/17.
//  Copyright © 2017 VnPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BBCUI)

// short code
@property (nonatomic, assign) CGFloat bbc_centerX;
@property (nonatomic, assign) CGFloat bbc_centerY;

@property (nonatomic, assign) CGFloat bbc_x;
@property (nonatomic, assign) CGFloat bbc_xRight;
@property (nonatomic, assign) CGFloat bbc_y;
@property (nonatomic, assign) CGFloat bbc_yBottom;
@property (nonatomic, assign) CGFloat bbc_width;
@property (nonatomic, assign) CGFloat bbc_height;

@property (nonatomic, assign) CGRect bbc_frameFixed;
@property (nonatomic, assign) CGFloat bbc_xFixed;
@property (nonatomic, assign) CGFloat bbc_xRightFixed;
@property (nonatomic, assign) CGFloat bbc_yFixed;
@property (nonatomic, assign) CGFloat bbc_yBottomFixed;
@property (nonatomic, assign) CGFloat bbc_widthFixed;
@property (nonatomic, assign) CGFloat bbc_heightFixed;


- (void)bbc_removeNSHeightConstant;
- (void)bbc_setNSWidthConstant:(float)constant;
- (void)bbc_setNSHeightConstant:(float)constant;
- (void)bbc_setNSHeightConstant:(float)constant force:(BOOL)force;
- (NSLayoutConstraint *)bbc_nsHeight;
- (NSLayoutConstraint *)bbc_nsWidth;
- (NSLayoutConstraint *)bbc_nsLeft;
- (NSLayoutConstraint *)bbc_nsTop;
- (NSLayoutConstraint *)bbc_nsRight;
- (NSLayoutConstraint *)bbc_nsBottom;
- (void) setRadius:(float)radius color:(UIColor*)colorBoder;
- (void) bbcSetCornerTop:(float)radius;
-(void) bidv_corner;

// layer
@property (nonatomic, assign) IBInspectable CGFloat bbc_cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat bbc_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *bbc_borderColor;

@property (nonatomic, assign) IBInspectable BOOL bbc_localizeView;
- (UIImage *) IMAGE_FROM_VIEW;
- (void)bbc_drawShadow;
- (void)bbc_drawShadowWithColor:(UIColor*)shadowColor size:(CGSize)size opacity:(float)opacity;
- (void)bbc_drawShadowWithColor:(UIColor*)shadowColor size:(CGSize)size opacity:(float)opacity shadowRadius:(CGFloat)shadowRadius;
- (void)bbc_drawShadowWithShadowRadius:(CGFloat)shadowRadius;

- (void)bbc_drawDaslineView;

// create
+ (instancetype)bbc_initFromNib;

@end

@interface UIButton(BSMObject)
-(void) touchUpAction:(void(^)(void)) action;
@end
