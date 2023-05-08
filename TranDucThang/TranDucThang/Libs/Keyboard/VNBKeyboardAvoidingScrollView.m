//
//  TPKeyboardAvoidingScrollView.m
//  TPKeyboardAvoiding
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2015 A Tasty Pixel. All rights reserved.
//

#import "VNBKeyboardAvoidingScrollView.h"
#import <objc/runtime.h>
#import "UIToolbarKeyboard.h"
#import "SDKTemplateCommonDefines.h"
#import "UIView+BBCUI.h"
@interface VNBKeyboardAvoidingScrollView () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIToolbarKeyboard *toolbar;
@property (nonatomic, strong) NSMutableArray * textEditables;
@end

@implementation VNBKeyboardAvoidingScrollView
-(void)scrollToActiveTextField_override
{
    UIView *firstResponder = [self TPKeyboardAvoiding_findFirstResponderBeneathView:self];
    if ([_textEditables containsObject:firstResponder] == NO) {
        return;
    }
    NSUInteger oldIndex = [_textEditables indexOfObject:firstResponder];
    [self enableButtonsAtIndex:oldIndex];
    
    [self scrollToActiveTextField];
}
-(void) enableButtonsAtIndex:(NSUInteger) index
{
    _toolbar.vBtPrev.enabled = index != 0;
    _toolbar.vBtNext.enabled = index != (_textEditables.count - 1);
}
#pragma mark - 
-(void) doneAction
{
    [self endEditing:YES];
}
-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
//    DLog(@"hrer");
}
-(void) nextPrevAction:(BOOL) next
{
    UIView *firstResponder = [self TPKeyboardAvoiding_findFirstResponderBeneathView:self];
    if ([_textEditables containsObject:firstResponder] == NO) {
        return;
    }
    NSUInteger oldIndex = [_textEditables indexOfObject:firstResponder];

    NSUInteger newIndex = oldIndex + (NSInteger)(next ? 1 : -1);
    if (newIndex < _textEditables.count)
    {
        UIView * newResponder = _textEditables[newIndex];
        [newResponder performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0];
//        [self enableButtonsAtIndex:newIndex];
    }
}
#pragma mark - Setup/Teardown

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TPKeyboardAvoiding_keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TPKeyboardAvoiding_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToActiveTextField) name:UITextViewTextDidBeginEditingNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToActiveTextField_override) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToActiveTextField_override) name:UITextViewTextDidBeginEditingNotification object:nil];

    self.toolbar = [UIToolbarKeyboard create];

    WEAK wSelf = self;
    [_toolbar setPrevAction:^{
        [wSelf nextPrevAction:NO];
    }];
    [_toolbar setNextAction:^{
        [wSelf nextPrevAction:YES];
    }];
    [_toolbar setDoneAction:^{
        [wSelf doneAction];
    }];
    
    self.textEditables = [NSMutableArray new];
    [self find_text_editable_in_view:self];
}

-(void) find_text_editable_in_view:(UIView *) view
{
    BOOL isTextView = [view isKindOfClass:[UITextView class]] || [view isKindOfClass:[UITextView class]];
    BOOL isTextField = [view isKindOfClass:[UITextField class]]&& ((UITextField *)view).enabled == YES;
    if (isTextField || isTextView)
    {
        ((UITextField *)view).inputAccessoryView = _toolbar;
        [_textEditables addObject:view];
        return;
    }
    NSArray * subViews = [view.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView* obj1, UIView* obj2)
    {
        return obj1.bbc_y > obj2.bbc_y;
    }];
    for (UIView * vSub in subViews) {
        [self find_text_editable_in_view:vSub];
    }
}

-(id)initWithFrame:(CGRect)frame
{
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    [self setup];
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
//    DLog(@"%s",__FUNCTION__);
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self TPKeyboardAvoiding_updateContentInset];
}

-(void)setContentSize:(CGSize)contentSize
{
    CGSize size = self.forceContentSize.height == 0 ? contentSize : self.forceContentSize;
    [super setContentSize:size];
    [self TPKeyboardAvoiding_updateFromContentSizeChange];
}

- (void)contentSizeToFit {
    self.contentSize = [self TPKeyboardAvoiding_calculatedContentSizeFromSubviewFrames];
}

- (BOOL)focusNextTextField {
    return [self TPKeyboardAvoiding_focusNextTextField];
    
}
- (void)scrollToActiveTextField
{
    return [self TPKeyboardAvoiding_scrollToActiveTextField];
}

#pragma mark - Responders, events

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if ( !newSuperview ) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self TPKeyboardAvoiding_findFirstResponderBeneathView:self] resignFirstResponder];
    [super touchesEnded:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    /*
    if ( ![self focusNextTextField] ) {
        [textField resignFirstResponder];
    }*/
    return YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object:self];
    [self performSelector:@selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) withObject:self afterDelay:0.1];
}

-(void)setContentSize1:(CGSize)contentSize
{
    [super setContentSize:contentSize];
}

-(void)setForceContentSize:(CGSize)forceContentSize
{
    [super setContentSize:forceContentSize];
    objc_setAssociatedObject(self, "forceContentSize",NSStringFromCGSize(forceContentSize), OBJC_ASSOCIATION_COPY);
}
-(CGSize)forceContentSize
{
    return CGSizeFromString(objc_getAssociatedObject(self,"forceContentSize"));

}

@end
