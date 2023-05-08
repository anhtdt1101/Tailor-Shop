//
//  TPKeyboardAvoidingScrollView.h
//  TPKeyboardAvoiding
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2015 A Tasty Pixel. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "UIScrollView+VNBKeyboardAvoidingAdditions.h"

@interface VNBKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>
- (void)contentSizeToFit;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;

@property (nonatomic,assign) CGSize forceContentSize;

@end
